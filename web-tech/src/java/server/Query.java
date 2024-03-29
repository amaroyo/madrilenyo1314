    /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package server;

import com.hp.hpl.jena.query.QueryExecution;
import com.hp.hpl.jena.query.QueryExecutionFactory;
import com.hp.hpl.jena.query.QuerySolution;
import com.hp.hpl.jena.query.ResultSet;
import com.hp.hpl.jena.rdf.model.Literal;
import com.hp.hpl.jena.rdf.model.Resource;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * Class to use all the query methods from all the project.
 *
 * @author Plasavall
 */
public class Query {
    private final static int MUST=1;
    private final static int CAN=0;
    private final static int NOT=-1;
    static String SERVICE = "http://dbpedia.org/sparql";
    static String PREFIXES = "PREFIX dbo:<http://dbpedia.org/ontology/> "
                      +"PREFIX dbres: <http://dbpedia.org/resource/> "
                      +"PREFIX dbpprop: <http://dbpedia.org/property/> ";
   
   
    private static Combination combination = new Combination();
   
   
    /**
     * Queries a list of recipes given a list of ingredients.
     * It's exclusive (Only the recipes containing at least that exact
     * ingredients are retrieved.
     * @param ingredients
     * @return a ResultSet of recipes containing the given list of ingredients
     */
    public static ArrayList <Recipe> recipes(ArrayList<Ingredient> ingredients){
        String i;
        ArrayList <Recipe> recipes = new ArrayList<>();
        ArrayList <String> nonDesired = new ArrayList<>();
        nonDesired.clear();
        nonDesired = getIByP(ingredients,NOT);
        ArrayList <String> mandatory = new ArrayList<>();
        mandatory.clear();
        mandatory = getIByP(ingredients,MUST);
        
        recipes.clear();
       
    String query=PREFIXES+"select ?recipe ?name_of_recipe where{";
    for (Ingredient ing : ingredients) {
            i=ing.getIngredientName();
            if(ing.getPriority() != NOT){
                query += "?recipe dbo:ingredient dbres:" + i + ".\n";
            }
        }
        query+="?recipe dbpprop:name ?name_of_recipe.\n";
        query+="}LIMIT 100";
        QueryExecution qe=QueryExecutionFactory.sparqlService(SERVICE, query);
        System.out.println("antes del exec select");
            ResultSet rs=qe.execSelect();
            Recipe auxRec;
            while(rs.hasNext()){
                QuerySolution s=rs.nextSolution();
                Resource recipeFound = s.getResource("?recipe");
                Literal nameOfRecipe = s.getLiteral("?name_of_recipe");
                System.out.println(recipeFound.toString().substring(28));
                try{
                    if(!recipeFound.toString().substring(28).contains("'") && !recipeFound.toString().substring(28).contains("(")){
                        System.out.println("NOT CONTAINS!");
                        auxRec = new Recipe(nameOfRecipe.getString(), ingredientsOfRecipe(recipeFound), snippetOfRecipe(recipeFound), imageOfRecipe(recipeFound));
                        if(mandatory.isEmpty() && nonDesired.isEmpty()){
                            System.out.println("Recipe Size: "+recipes.size());
                            recipes.add(auxRec);
                        }else if(!auxRec.hasIngredients(nonDesired) && auxRec.hasIngredients(mandatory)){
                            System.out.println("Recipe Size: "+recipes.size());
                            recipes.add(auxRec);
                        }
                    }
                }catch(Exception ex){
                }
        }
        System.out.println("Finished looking recipes.");

        return recipes;
    }
    /**
     * This method returns the recipes of the result of querying with the combinations
     * of 'hits' ingredients.
     *
     * @param ingredients
     * @param hits
     * @return
     */
    public static ArrayList <Recipe> recipes(ArrayList<Ingredient> ingredients, int hits){
       
        if(hits > ingredients.size()) return null;
        if(hits == ingredients.size()) return recipes(ingredients);
        ArrayList <Recipe> recipesFound = new ArrayList<>();
        ArrayList <Ingredient> auxIngr = new ArrayList<>();
        recipesFound.clear();
        if(hits == 1){
            for(int i = 0; i < ingredients.size(); i++){
                auxIngr.clear();
                auxIngr.add(ingredients.get(i));
                recipesFound.addAll(recipes(auxIngr));
            }
            return recipesFound;
        }
        else{
            ArrayList <int []> indexes = giveCombinations(ingredients.size(), hits);
            for(int i = 0; i < indexes.size();i++){
                auxIngr.clear();
                for(int j = 0; j < indexes.get(i).length;j++){
                    auxIngr.add(ingredients.get(indexes.get(i)[j]));
                }
                recipesFound.addAll(recipes(auxIngr));
            }
            return recipesFound;
        }
    }
    /**
     *
     * @param recipe is a dbresource
     * @return an arrayList of Strings (ingredient names)
     */
    public static ArrayList <String> ingredientsOfRecipe(Resource resRecipe){
        String recipe = resRecipe.toString().substring(28);
        //System.out.println("dbres:"+recipe);
        ArrayList <String> ingredients = new ArrayList<>();
        ingredients.clear();
        String query=PREFIXES+"select ?ingredient_names where{";
        query +="dbres:"+recipe+" dbo:ingredient ?ingredients."
                    + "?ingredients dbpprop:name ?ingredient_names.";
        query+="}";
        QueryExecution qe=QueryExecutionFactory.sparqlService(SERVICE, query);
        ResultSet rs=qe.execSelect();
        while(rs.hasNext()){
            QuerySolution s=rs.nextSolution();
            Literal name=s.getLiteral("?ingredient_names");
            ingredients.add(name.getString().replaceAll("[\"<>ºª|·$%&/()=~€¬`^¨çÇ_+*;:\\-\\[\\]\\\\]", ""));            
        }
        System.out.print("Ingredients: ");
        for(int i=0;i<ingredients.size();i++){
            System.out.print(ingredients.get(i));
        }
        System.out.println("");
        return ingredients;
           
    }
    /**
     * Returns the description (in english) of the requested recipe.
     * @param recipe
     * @return the description in a String form.
     */
    public static String snippetOfRecipe(Resource resRecipe){
        String recipe = resRecipe.toString().substring(28);
        String snippet = "No description available.";
        String query=PREFIXES+"select ?snippet where{"
                +"dbres:"+recipe+" dbo:abstract ?snippet.\n"
                + "FILTER (langMatches(lang(?snippet),\"en\"))\n"
                + "}";
        QueryExecution qe=QueryExecutionFactory.sparqlService(SERVICE, query);
        ResultSet rs=qe.execSelect();
        while(rs.hasNext()){
            QuerySolution s=rs.nextSolution();
            Literal snipLiteral = s.getLiteral("?snippet");
            snippet = snipLiteral.getString();
        }
        snippet = snippet.replaceAll("[\"<>ºª|·$%&/()=~€¬`^¨çÇ_+*;:\\-\\[\\]\\\\]", "");
       
        System.out.println("Snippet: "+snippet);
        return snippet;
    }
    /**
     * Returns the image of the requested recipe.
     * @param recipe
     * @return the image link in a String form.
     */    
    public static String imageOfRecipe(Resource resRecipe){
        String recipe = resRecipe.toString().substring(28);
        String image = "No image available.";
        String query=PREFIXES+"select ?image where{"
                +"dbres:"+recipe+" dbo:thumbnail ?image.\n"
                + "}";
        QueryExecution qe=QueryExecutionFactory.sparqlService(SERVICE, query);
        ResultSet rs=qe.execSelect();
        while(rs.hasNext()){
            QuerySolution s=rs.nextSolution();
            Resource imLiteral = s.getResource("?image");
            image = imLiteral.toString();
        }
        System.out.println("Image: "+image);
        return image;
    }
    /**
     * Returns the image of the requested recipe.
     * @param recipe
     * @return the image link in a String form.
     */    
    public static String nameOfRecipe(Resource resRecipe){
        String recipe = resRecipe.toString().substring(28);
        String name = "No name available.";
        String query=PREFIXES+"select ?name where{"
                +"dbres:"+recipe+" dbpprop:name ?name.\n"
                + "}";
        QueryExecution qe=QueryExecutionFactory.sparqlService(SERVICE, query);
        ResultSet rs=qe.execSelect();
        while(rs.hasNext()){
            QuerySolution s=rs.nextSolution();
            Literal imLiteral = s.getLiteral("?name");
            name = imLiteral.getString();
        }
        name = name.replaceAll("[\"<>ºª|·$%&/()=~€¬`^¨çÇ_+*;:\\-\\[\\]\\\\]", "");
        return name;
    }
   
    /**
     * getIByP stands for Get ingredients by priority.
     * It returns a list of the ingredient names in that list that have the
     * given priority
     * @param ingredients
     * @param priority
     * @return
     */
    private static ArrayList <String> getIByP(ArrayList<Ingredient> ingredients, int priority){
        ArrayList <String> result = new ArrayList<>();
        result.clear();
        for(Ingredient ing : ingredients){
            if(ing.getPriority()==priority) result.add(ing.getIngredientName());
        }
        if(!result.isEmpty())
            for(int i=0;i<result.size();i++){
                System.out.println((priority == MUST)?"MUST: "+result.get(i):"NOT: "+result.get(i));
            }
        return result;
    }

    /**
     * It returns the indexes of the ingredients in each combination.
     *
     * @param elements number of ingredients
     * @param hits number of elements per combination
     * @return
     */
    private static ArrayList<int[]> giveCombinations(int elements, int hits) {
        if(hits == 0) {
            
        }
        ArrayList <String> temp = new ArrayList <> ();
        for(int i = 0; i < hits; i++)
            temp.add(i+"");
       
        combination.setter(temp, hits);
        Iterator s = combination.iterator();  
        ArrayList<List<String>>  l2 = new ArrayList();  

        while (s.hasNext()) {  
            List<String> listares = (List<String>) s.next();  
            l2.add(listares);
        }
       
        ArrayList <int[]> al = new ArrayList <> ();
                  for(int i = 0; i < l2.size(); i++) {
                          int[] pos = new int[l2.get(i).size()];
                          for(int j = 0; j < l2.get(i).size(); j++) {
                                  pos[j] = Integer.parseInt(l2.get(i).get(j));
                          }
                          al.add(pos);
                  }
        return al;
    }

}
