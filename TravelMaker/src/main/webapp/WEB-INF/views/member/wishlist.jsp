<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>

#container {
	width: 74%;
	margin:0 auto;
}

.wishlistCategory {
	width: 23.5%; 
	height: 20%; 
	display: inline-block; 
	margin: 0 1% 3% 0;
	cursor: pointer;
}

</style>

<div class="container" style="height: 100rem;">
	<div style="margin: 4% 0 3% 0;">
		<h1 style="font-weight: bold;">위시리스트</h1>
	</div>
	<div style="width: 100%; height: 100%;">
		<c:forEach var="wishlistCategory" items="${wishlistCategoryList }">
			<div class="wishlistCategory" onclick="wishlistCategoryDetail('${wishlistCategory.wishlistCategoryNo }')">
				<c:choose>
					<c:when test="${not empty wishlistCategory.attPath }">
						<div style="width: 100%; height: 100%;">
							<img alt="#" src="${wishlistCategory.attPath }" style="width: 100%; height: 100%; border-radius: 10px;">
						</div>
					</c:when>
					<c:otherwise>
						<div style="width: 100%; height: 100%; background-color: #8e8e8e; border-radius: 10px;"></div>
					</c:otherwise>
				</c:choose>
				<div><h3>${wishlistCategory.wishlistCategoryName }</h3></div>
			</div>
		</c:forEach>
	</div>
</div>

<script>
	$(function() {
		
	});
	
	function wishlistCategoryDetail(wishlistCategoryNo) {
		location.href = "/member/wishlist/detail/" + wishlistCategoryNo;
	}
</script>

































