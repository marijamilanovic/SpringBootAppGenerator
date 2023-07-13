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
        <h3 class="text-center">${class.name?cap_first} details</h3>
        <div>
        	<form action="update" method="post">
        	 	<input type="hidden" id="id" name="id" value="${'${' + class.name?uncap_first + 'Dto.id}'}">
        		<br>
        		<#list persistentProperties as property>
                	<#if property.name != "id" && (property.type == "String" || property.type == "Integer")>
            	<label for="${property.name?uncap_first}">${property.name?cap_first}:</label>
        		<input type="text" id="${property.name?uncap_first}" name="${property.name?uncap_first}" value="${'${' + class.name?uncap_first + 'Dto.' + property.name + '}'}">
        		<br>
					</#if>
               	</#list>
                <br>
                <#list referencedProperties as property>
	                <#if property.upper == 1 && property.oppositeEnd == -1>
	            <div class="button-container">
		            <label>${property.name?cap_first} [id]:</label>
					<select name="${property.name?uncap_first}Id" class="margin-left: 20px">
						<c:forEach var="${property.type?lower_case}" items="${'${' + property.type?uncap_first + 'List}'}">
							<option value="${property.name?uncap_first}Id" ${'${' + property.type?lower_case + '.id eq ' + property.name?uncap_first +  'Id' + "? 'selected' : ''}"}>
									${'${' + property.type?lower_case + '.id}'}
							</option>
						</c:forEach>
					</select>
				</div>
				<br>
					</#if>
                	<#if property.upper == -1 && property.oppositeEnd == 1>
            	<label>${property.name?cap_first} [id]:</label>
	            		<#if property.type?ends_with("y")>
				<c:forEach var="item" items="${'${' + class.name?uncap_first + 'Dto.' + property.type?substring(0,1)?lower_case + class.name?substring(1, class.name?length-1) + 'ies}'}">
						<#elseif property.type?ends_with("s")>
				<c:forEach var="item" items="${'${' + class.name?uncap_first + 'Dto.' + property.type?uncap_first + '}'}">
						<#else>
				<c:forEach var="item" items="${'${' + class.name?uncap_first + 'Dto.' + property.type?uncap_first + 's}'}">
						</#if>
					<li><a href="#" onclick="redirectToPage(${"'/" + property.type?lower_case + "/" + '${' + 'item.id' + '}'+ "'"})">${'${' + 'item.id' + '}'}</a></li>
					<br>
				</c:forEach>
				<br>
				<input type="button" class="btn btn-outline-primary btn-sm mb-3" value="Add new ${property.type?lower_case}" onclick="redirectToPage(${"'/"+property.type?lower_case+"/new?parent="+ class.name?uncap_first+'&id='+'${' + class.name?uncap_first + "Dto.id}'"})">
				<br>
				<br>
					</#if>
               	</#list>
				<br>
				<br>
                <div class="button-container">
					<input type="submit" class="btn btn-outline-primary btn-sm mb-3" value="Save">
					<form action="delete/${'${' + class.name?uncap_first + 'Dto.id}'}" method="post">
		    			<input type="hidden" name="_method" value="DELETE">
		    			<input type="submit" class="btn btn-danger btn-sm mb-3" value="Delete">
					</form>
				</div>
    		</form>
        </div>
     </div>
  </body>
</html>