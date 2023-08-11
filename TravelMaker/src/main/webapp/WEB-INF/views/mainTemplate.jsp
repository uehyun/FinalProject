<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<title>Travel Maker</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="icon" href="${pageContext.request.contextPath}/resources/images/travel_airplane.png">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main-color.css" id="colors">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/jquery-migrate-3.3.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/mmenu.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/chosen.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/slick.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/rangeslider.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/magnific-popup.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/waypoints.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/counterup.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/jquery-ui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/tooltips.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/custom.js"></script>
<script src="${pageContext.request.contextPath }/resources/scripts/ckeditor/ckeditor.js"></script>
<script 
src="https://cdnjs.cloudflare.com/ajax/libs/Sortable/1.15.0/Sortable.min.js" 
integrity="sha512-Eezs+g9Lq4TCCq0wae01s9PuNWzHYoCMkE97e2qdkYthpI0pzC3UGB03lgEHn2XM85hDOUF6qgqqszs+iXU4UA==" 
crossorigin="anonymous" 
referrerpolicy="no-referrer"></script>

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

</head>
<body>
	<div id="wrapper">
	
		<tiles:insertAttribute name="mainheader"/>
	
		<tiles:insertAttribute name="content"/>
	
		<tiles:insertAttribute name="mainfooter"/>
	
		<div id="backtotop">
			<a href="#"></a>
		</div>
	
	</div>
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/typed.js"></script>
	<script>
		var typed = new Typed('.typed-words', {
		strings: [" Attractions"," Designer"," Journey"],
			typeSpeed: 80,
			backSpeed: 80,
			backDelay: 4000,
			startDelay: 1000,
			loop: true,
			showCursor: true
		});
	</script>
	
	<!-- Home Search Scripts -->
	<script>
		$(window).on('load', function() { $('.msps-shapes').addClass('shapes-animation'); });
	</script>
	 
	<script src="${pageContext.request.contextPath }/resources/scripts/parallax.min.js"></script>
	<script>
		/* const parent = document.getElementById('scene');
		const parallax = new Parallax(parent, {
		  limitX: 50,
		  limitY: 50,  
		}); */
		 
		 
		$('.msps-slider').slick({
		    infinite: true,
		    slidesToShow: 1,
		    slidesToScroll: 1,
		    dots: true,
		    arrows: false,
		    autoplay: true,
		    autoplaySpeed: 5000,
		    speed: 1000,
		    fade: true,
		    cssEase: 'linear'
		});
	</script>
</body>
</html>