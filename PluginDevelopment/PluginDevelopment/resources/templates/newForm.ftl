<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
    .button-container {
        display: flex;
        gap: 10px;
        align-items: center;
    }
</style>

<script>
	function redirectToPage(url) {
		// Redirect to the desired page
		window.location.href = url;
	}
</script>

<!DOCTYPE html>
<html>
  <body>
    <%@include file="navbar.jsp"%>
	<div class="container">
		<br/>
        <h3 class="text-center">New ${class.name?cap_first}</h3>
        <div>
        	<form action="save?parent=${'${'+'param.parent'+'}'}&id=${'${'+'param.id'+'}'}" method="post">
        		<br>
        		<#list persistentProperties as property>
                	<#if property.name != "id" && (property.type == "String" || property.type == "Integer")>
            	<label for="${property.name?uncap_first}">${property.name?cap_first}:</label>
        		<input type="text" id="${property.name?uncap_first}" name="${property.name?uncap_first}" value="${'${' + class.name?uncap_first + '.' + property.name + '}'}">
        		<br>
					</#if>
               	</#list>
                <br>
				<br>
                <div class="button-container">
					<input type="submit" value="Save">
				</div>
    		</form>
        </div>
     </div>
  </body>
</html>