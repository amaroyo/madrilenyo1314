function loadXMLDoc(url) {
	var xmlhttp;
	var txt,x,i;
	if (window.XMLHttpRequest)
	  {// code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {// code for IE6, IE5
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState===4 && xmlhttp.status===200)
		{
		
		x=xmlhttp.responseXML.documentElement.getElementsByTagName("RECIPE");
		txt='<ul class="media-list">';
		for (i=0;i<x.length;i++)
		  {
			txt=txt + '<li class="media">';
			txt=txt + '<a class="pull-left" href="#">' +
					'<img class="media-object" src="Resources/icons/64x64/images.jpg">' + 
					'</a><div class="media-body">' +
					'<h4 class="media-heading">' +
					x[i].getAttribute('NAME') + '</h4>' +
					'<h5>'+ x[i].getElementsByTagName("INGREDIENT")[0].innerHTML +'</h5>'+		
					'<p>' + x[i].getElementsByTagName("SNIPPET")[0].innerHTML + '</p>' +
					'</div></li>';
			
		  }
		txt=txt + '</ul>';
		document.getElementById('txtRecetas').innerHTML=txt;
		}
	  };
	xmlhttp.open("GET",url,true);
	xmlhttp.send();
}

function newUser() {
        
        var xmlhttp;
	if (window.XMLHttpRequest)
	  {// code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {// code for IE6, IE5
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
   
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState===4 && xmlhttp.status===200)
		{
		document.getElementById("IngredientButtonResult").innerHTML=xmlhttp.responseText;
		}
	  };
        xmlhttp.open("GET","http://localhost:8080/web-tech/webresources/lookandcook/user",true);
	xmlhttp.send();
}


var ingredients = ["almonds",
"apple",
"apricot",
"asparagus",
"avocado",
"banana",
"barley",
"basil",
"beef",
"beet greens",
"beets",
"bell peppers",
"black beans",
"black pepper",
"blueberries",
"bok choy",
"broccoli",
"brown rice",
"brussels sprouts",
"buckwheat",
"cabbage",
"cantaloupe",
"carrots",
"cashews",
"cauliflower",
"cayenne pepper",
"celery",
"cheese",
"chicken",
"chili pepper",
"cilantro",
"cinnamon",
"cloves",
"cod",
"collard greens",
"coriander",
"corn",
"cranberries",
"cucumber",
"cumin",
"dill",
"dried peas",
"eggplant",
"eggs",
"fennel",
"figs",
"flax seeds",
"garbanzo beans",
"garlic",
"ginger",
"grapefruit",
"grapes",
"green beans",
"green peas",
"green tea",
"honey",
"kale",
"kidney beans",
"kiwifruit",
"lamb",
"leeks",
"lemons", 
"limes",
"lentils",
"lima beans",
"limes",
"maple syrup",
"milk",
"millet",
"miso",
"molasses",
"blackstrap",
"mushrooms",
"crimini",
"mushrooms",
"shiitake",
"mustard greens",
"mustard seeds",
"navy beans",
"oats",
"olive oil",
"olives",
"onions",
"oranges",
"oregano",
"papaya",
"parsley",
"peanuts",
"pear",
"peppermint",
"pineapple",
"pinto beans",
"plum",
"potatoes",
"prunes",
"pumpkin seeds",
"quinoa",
"raisins",
"raspberries",
"romaine lettuce",
"rosemary",
"rye",
"sage",
"salmon",
"sardines",
"scallops",
"sea vegetables",
"sesame seeds",
"shrimp",
"soy sauce",
"soybeans",
"spelt",
"spinach",
"strawberries",
"summer squash",
"sunflower seeds",
"sweet potato",
"swiss chard",
"tempeh",
"thyme",
"tofu",
"tomatoes",
"tuna",
"turkey",
"turmeric",
"turnip greens",
"walnuts",
"water",
"watermelon",
"wheat",
"winter squash",
"yams",
"yogurt"];

function getHint(input) {
    // get the q parameter from URL
    var hint="";
    var ingredient;
    
    // lookup all hints from array if input is different from ""
    if (input !== "") {
        input.toLowerCase(); 
        for(var i=0;i<ingredients.length;i++) {
            ingredient = ingredients[i];
            if (ingredient.indexOf(input) !== -1) {
                if (hint === ""){
                    hint = "  Suggestions: ";
                    hint =hint + ingredient;
                }
                else {
                    hint = hint + ", " + ingredient;
                }
            }
          }
        }

    // Output "no suggestion" if no hint were found
    // or output the correct values
    if(hint === "") {
        hint = "  No suggestions";
    }
    document.getElementById("txtHint").innerHTML=hint;
}
