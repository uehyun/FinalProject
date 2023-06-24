<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html>
<head>

<!-- Basic Page Needs
================================================== -->
<title>Travel Maker</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

<!-- CSS
================================================== -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/main-color.css" id="colors">

</head>
<body>
<!-- Wrapper -->
<div id="wrapper">

	<tiles:insertAttribute name="mainheader"/>

	<tiles:insertAttribute name="content"/>

	<tiles:insertAttribute name="mainfooter"/>

<!-- Back To Top Button -->
<div id="backtotop"><a href="#"></a></div>

</div>
<!-- Wrapper / End -->


<!-- Scripts
================================================== -->
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/scripts/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/scripts/jquery-migrate-3.3.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/scripts/mmenu.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/scripts/chosen.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/scripts/slick.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/scripts/rangeslider.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/scripts/magnific-popup.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/scripts/waypoints.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/scripts/counterup.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/scripts/jquery-ui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/scripts/tooltips.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/scripts/custom.js"></script>


<!-- Leaflet // Docs: https://leafletjs.com/ -->
<script src="${pageContext.request.contextPath }/resources/scripts/leaflet.min.js"></script>

<!-- Leaflet Maps Scripts -->
<script src="${pageContext.request.contextPath }/resources/scripts/leaflet-markercluster.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/scripts/leaflet-gesture-handling.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/scripts/leaflet-listeo.js"></script>

<!-- Leaflet Geocoder + Search Autocomplete // Docs: https://github.com/perliedman/leaflet-control-geocoder -->
<script src="${pageContext.request.contextPath }/resources/scripts/leaflet-autocomplete.js"></script>
<script src="${pageContext.request.contextPath }/resources/scripts/leaflet-control-geocoder.js"></script>



<!-- Typed Script -->
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/scripts/typed.js"></script>

<!-- ----------------------------------------------------------- -->
<!-- ----------------------------------------------------------- -->
<!-- ----------------------------------------------------------- -->
<script>
var typed = new Typed('.typed-words', {
strings: ["Attractions"," Restaurants"," Hotels"],
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
const parent = document.getElementById('scene');
const parallax = new Parallax(parent, {
  limitX: 50,
  limitY: 50,  
});
 
 
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