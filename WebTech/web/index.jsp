<%@ page contentType="xhtml; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%! String RAQ=""; %>

<jsp:useBean id="ser" class="Server.Controller" scope="application"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<link href="Resources/css/my_style.css" rel="stylesheet" type="text/css">
<!-- Bootstrap -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="Resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="Resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">




<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>Welcome to Look &amp; Cook</title>
    
    
    
    <script>
		function loadXMLDoc(url)
		{
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
		  if (xmlhttp.readyState==4 && xmlhttp.status==200)
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
		  }
		xmlhttp.open("GET",url,true);
		xmlhttp.send();
		}
</script>


<script>
function showHint(str)
{
var xmlhttp;
if (str.length==0)
  { 
  document.getElementById("txtHint").innerHTML="";
  return;
  }
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
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
    document.getElementById("txtHint").innerHTML=xmlhttp.responseText;
    }
  }
xmlhttp.open("GET","gethint.php?q="+str,true);
xmlhttp.send();
}
</script>



<script>
function newUser() {
	<%      
                RAQ = ser.newUser();
		
	%>
            document.getElementById("micaca").innerHTML="<%=RAQ%>";    
}

</script>
	
</head>
<body>

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://code.jquery.com/jquery.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="Resources/bootstrap/js/bootstrap.min.js"></script>

<div id="wrapper">
	
    
    <div id="history">
        <p><center><b>Last searches</b></center></p> 
        <br />
    	<ul>
      		<li><p>Búsqueda1</p></li>
      		<li><p>Búsqueda2</p></li>
      		<li><p>Búsqueda3</p></li>
      		<li><p>Búsqueda4</p></li>
            <li><p>Búsqueda4</p></li>
            <li><p>Búsqueda4</p></li>
            <li><p>Búsqueda4</p></li>
            <li><p>Búsqueda4</p></li>
            <li><p>Búsqueda4</p></li>
            <li><p>Búsqueda4</p></li>
    	</ul>
  	</div>
    
	<div id="header"> 
		<a href="index.html"><img src="Resources/images/logo.png" width="180" height="240" alt="logo" />
        </a>
        
        
        
    	<!--Carousel!-->
		<div id="carousel-example-generic" class="carousel slide" data-ride="carousel" data-pause="hover">
       
          <!-- Indicators -->
          <ol class="carousel-indicators">
            <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
            <li data-target="#carousel-example-generic" data-slide-to="1"></li>
            <li data-target="#carousel-example-generic" data-slide-to="2"></li>
          </ol>
        
          <!-- Wrapper for slides -->

          <div class="carousel-inner">
            <div class="item active">
              <img src="Resources/images/carousel 300x200/carousel1.jpg" alt="300x200">
              <h3>Cocidito madrileño</h3>
              <p>rico,rico...</p>
              <div class="carousel-caption">
              </div>
            </div>
            <div class="item">
              <img src="Resources/images/carousel 300x200/carousel2.jpg" alt="300x200">
              <h3>Otra receta</h3>
              <p>descripción...</p>
              <div class="carousel-caption">
              </div>
            </div>
            <div class="item">
              <img src="Resources/images/carousel 300x200/carousel3.jpg" alt="300x200">
              <h3>Tortilla de patatas</h3>
              <p>con cebolla...</p>
              <div class="carousel-caption">
              </div>
            </div>
            <div class="item">
              <img src="Resources/images/carousel 300x200/carousel4.jpg" alt="300x200">
              <h3>Otra receta</h3>
              <p>descripción...</p>
              <div class="carousel-caption">
              </div>
            </div>
            <div class="item">
              <img src="Resources/images/carousel 300x200/carousel5.jpg" alt="300x200">
              <h3>Otra receta</h3>
              <p>descripción...</p>
              <div class="carousel-caption">
              </div>
            </div>
            <div class="item">
              <img src="Resources/images/carousel 300x200/carousel6.jpg" alt="300x200">
              <h3>Otra receta</h3>
              <p>descripción...</p>
              <div class="carousel-caption">
              </div>
            </div>
            <div class="item">
              <img src="Resources/images/carousel 300x200/carousel7.jpg" alt="300x200">
              <h3>Otra receta</h3>
              <p>descripción...</p>
              <div class="carousel-caption">
              </div>
            </div>
            <div class="item">
              <img src="Resources/images/carousel 300x200/carousel8.jpg" alt="300x200">
              <h3>Otra receta</h3>
              <p>descripción...</p>
              <div class="carousel-caption">
              </div>
            </div>
            <div class="item">
              <img src="Resources/images/carousel 300x200/carousel9.jpg" alt="300x200">
              <h3>Otra receta</h3>
              <p>descripción...</p>
              <div class="carousel-caption">
              </div>
            </div>
            <div class="item">
              <img src="Resources/images/carousel 300x200/carousel10.jpg" alt="300x200">
              <h3>Otra receta</h3>
              <p>descripción...</p>
              <div class="carousel-caption">
              </div>
            </div>
            
          </div>
        
          <!-- Controls -->
          <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left"></span>
          </a>
          <a class="right carousel-control" href="#carousel-example-generic" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right"></span>
          </a>
      </div>
        <!--Carousel!-->
    <!-- <h5><b><center>Top 10 recipes</center></b></h5>-->
        
  </div>
    
    
   
    <hr style="display: block; border:solid #000 1px; box-shadow: 3px 3px 6px #000; background-color: #000"/>
    
    
    
	<div id="content">
        <div id="search">
            <p><left><b>Advanced Search</b></left></p>
            <br />
            <div id="ingredients">
            
            <!--	<form class="navbar-search pull-left" style="margin-left:60px">
					<input type="text" class="search-query" placeholder="Search">
				</form> -->
                
               <form id="form1" action="" method="post" autocomplete='off'>
                  <div class="dynamiclabel">
                    <input id="search" placeholder="Search me" type="text" onkeyup="showHint(this.value)" />
                    <label for="search"><p><strong>Search for some ingredients!</strong></p></label>
                  </div>
                  <p><span id="txtHint"></span></p>





                  
                    <p>
                      <label style="margin-left:20px">
                        <input type="radio" name="Choices" value="radio" id="Choices_0" />
                        I like it!
                      </label>
                      <label style="margin-left:50px">
                        <input name="Choices" type="radio" id="Choices_1" value="radio" checked="checked" />
                        Maybe
                      </label>
                      <label style="margin-left:50px">
                        <input type="radio" name="Choices" value="radio" id="Choices_2" />
                        I hate it!
                      </label>                  
                    </p>
                 
              </form>
              
              
              <div class="row" id="resultado">
                  <div id="gusta" class="col-xs-4">
                    <ul>
                      <li>Presentacion</li>
                      <li>Galería de Imágenes</li>
                      <li>Detalles</li>
                      <li>Encargo</li>
                    </ul>
                  </div>
                  
                  <div id="puede" class="col-xs-4">
                    <ul>
                      <li>Presentacion</li>
                      <li>Galería de Imágenes</li>
                      <li>Detalles</li>
                      <li>Encargo</li>
                    </ul>
                  </div>
               
               	  <div id="noGusta" class="col-xs-4">
                    <ul>
                      <li>Presentacion</li>
                      <li>Galería de Imágenes</li>
                      <li>Detalles</li>
                      <li>Encargo</li>
                    </ul>
                  </div>

                
          </div> 
             <br /><br />
             
           <hr style="display: block; border:solid #000 1px; box-shadow: 3px 3px 6px #000; background-color: #000"/>  
             
            <div id="results"><p><strong>Resultados de recetas</strong></p>
            
            	<div id="txtRecetas">
					<!--<button onclick="loadXMLDoc('xml/receta.xml')">Get Recipes</button>-->
                    <button id = "micaca" onclick="newUser()">Get User</button>
           		</div>
                
            </div> 
        </div>
        
        <hr style="display: block; border:solid #000 1px; box-shadow: 3px 3px 6px #000; background-color: #000"/>
        
        <div id="recommended"><p><strong>Recomendadas</strong></p></div>
        
        <hr style="display: block; border:solid #000 1px; box-shadow: 3px 3px 6px #000; background-color: #000"/>
        
        <div id="related"><p><strong>Relacionadas</strong></p></div>
    </div>
    
	<hr style="display: block; border:solid #000 1px; box-shadow: 3px 3px 6px #000; background-color: #000"/>    


  <div id="footer">
    	
        <ul class="flipboard">
            <li><a href="http://www.lookandcook.uni.me"><span>l</span></a></li>
            <li><a href="http://www.lookandcook.uni.me"><span>o</span></a></li>
            <li><a href="http://www.lookandcook.uni.me"><span>o</span></a></li>
            <li><a href="http://www.lookandcook.uni.me"><span>k</span></a></li>
            <li><a href="http://www.lookandcook.uni.me"><span>&amp;</span></a></li>
            <li><a href="http://www.lookandcook.uni.me"><span>c</span></a></li>
            <li><a href="http://www.lookandcook.uni.me"><span>o</span></a></li>
            <li><a href="http://www.lookandcook.uni.me"><span>o</span></a></li>
            <li><a href="http://www.lookandcook.uni.me"><span>k</span></a></li>
        </ul>
        
        
        

        <p id="socialicons">
        <a href="http://www.facebook.com/">
        <img border="0" src="Resources/icons/48x48/facebook.png" /></a>
        <a href="http://www.twitter.com/">
        <img border="0" src="Resources/icons/48x48/twitter.png" /></a>
        <a href="http://www.yahoo.com/">
        <img border="0" src="Resources/icons/48x48/yahoo.png" /></a>
        <a href="http://www.youtube.com/">
        <img border="0" src="Resources/icons/48x48/youtube.png" /></a>
      </p>
        
    <strong>Look &amp; Cook 2014 - all rights reserved ©<strong>

		<br /><br /><br />
    
    
  </div>
</div>
</div>

</body>
</html>