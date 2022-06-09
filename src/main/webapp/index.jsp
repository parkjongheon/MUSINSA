<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>javagreenJ프로젝트(박종헌)</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ include file="/include/bs4.jsp"%> <!-- bs4 주석 -->
	<script>
		w3.slideshow(".nature", 3000);
	</script>
	<style>
	.mySlides {display:none;}
	</style>
</head>
<body>
 
<!-- Links (sit on top) -->
	<%@ include file="/include/nav.jsp"%> <!-- bs4 주석 -->

<!-- Content -->
<div class="w3-content" style="max-width:1100px;margin-top:80px;margin-bottom:80px">

  <div class="w3-panel">
    <h1><b>MUSINSA</b></h1>
  </div>

  <!-- Slideshow -->
  <div class="w3-container">
    <div class="w3-content w3-display-container" style="max-width:1200px">
		  <img class="mySlides w3-animate-right" src="./images/main1.jpg" style="width:100%;height: 500px">
		  <img class="mySlides w3-animate-right" src="./images/adad.PNG" style="width:100%;height: 500px">
		  <img class="mySlides w3-animate-right" src="./images/1212.PNG" style="width:100%;height: 500px">
		  <div class="w3-center w3-container w3-section w3-large w3-text-white w3-display-bottommiddle" style="width:100%">
		    <div class="w3-left w3-hover-text-khaki" onclick="plusDivs(-1)">&#10094;</div>
		    <div class="w3-right w3-hover-text-khaki" onclick="plusDivs(1)">&#10095;</div>
		    <span class="w3-badge demo w3-border w3-transparent w3-hover-white" onclick="currentDiv(1)"></span>
		    <span class="w3-badge demo w3-border w3-transparent w3-hover-white" onclick="currentDiv(2)"></span>
		    <span class="w3-badge demo w3-border w3-transparent w3-hover-white" onclick="currentDiv(3)"></span>
		  </div>
		</div>
  </div>
  <!-- Grid -->
  
  <div class="w3-row w3-container">
    <div class="w3-center w3-padding-64">
      <span class="w3-xlarge w3-bottombar w3-border-dark-grey w3-padding-16">What We Offer</span>
    </div>
    <div class="w3-container">
  		<img class="w3-animate" src="./images/1111.jpg" style="width:100%">
  	</div>
    <div class="w3-col l3 m6 w3-light-grey w3-container w3-padding-16">
      <h3>Design</h3>
      <p>Phasellus eget enim eu lectus faucibus vestibulum. Suspendisse sodales pellentesque elementum.</p>
    </div>

    <div class="w3-col l3 m6 w3-grey w3-container w3-padding-16">
      <h3>Branding</h3>
      <p>Phasellus eget enim eu lectus faucibus vestibulum. Suspendisse sodales pellentesque elementum.</p>
    </div>

    <div class="w3-col l3 m6 w3-dark-grey w3-container w3-padding-16">
      <h3>Consultation</h3>
      <p>Phasellus eget enim eu lectus faucibus vestibulum. Suspendisse sodales pellentesque elementum.</p>
    </div>

    <div class="w3-col l3 m6 w3-black w3-container w3-padding-16">
      <h3>Promises</h3>
      <p>Phasellus eget enim eu lectus faucibus vestibulum. Suspendisse sodales pellentesque elementum.</p>
    </div>
		  <div class="w3-half w3-container">
		  <img src="./images/main11.PNG" style="width:100%">
		  <p class="w3-xlarge w3-text-grey">
		  Demos, Logos, Reports, Names, Events, Media, Wordpress, Google, Books, Optimisations</p>
		</div>
		  <div class="w3-half w3-container">
		  <img src="./images/main2.PNG" style="width:100%">
		  <p class="w3-xlarge w3-text-grey">
		  Demos, Logos, Reports, Names, Events, Media, Wordpress, Google, Books, Optimisations</p>
		</div>
  </div>
</div>

<!-- Footer -->
<%@ include file="/include/footer.jsp"%>
<script>
var slideIndex = 1;
showDivs(slideIndex);

function plusDivs(n) {
  showDivs(slideIndex += n);
}

function currentDiv(n) {
  showDivs(slideIndex = n);
}

function showDivs(n) {
  var i;
  var x = document.getElementsByClassName("mySlides");
  var dots = document.getElementsByClassName("demo");
  if (n > x.length) {slideIndex = 1}
  if (n < 1) {slideIndex = x.length}
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";  
  }
  for (i = 0; i < dots.length; i++) {
    dots[i].className = dots[i].className.replace(" w3-white", "");
  }
  x[slideIndex-1].style.display = "block";  
  dots[slideIndex-1].className += " w3-white";
}
</script>
<script>
var myIndex = 0;
carousel();

function carousel() {
  var i;
  var x = document.getElementsByClassName("mySlides");
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";  
  }
  myIndex++;
  if (myIndex > x.length) {myIndex = 1}    
  x[myIndex-1].style.display = "block";  
  setTimeout(carousel, 4000); // Change image every 2 seconds
}
</script>
 </body>
</html>