<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
  <body>
    <%@include file="navbar.jsp"%>
	<div class="container">
		<br/>
        <h3 class="text-center">Edit ${class.name?cap_first}</h3>
        <div>
        	<form action="save" method="post">
        		<br>
        		<#list persistentProperties as property>
                	<#if property.name != "id" && (property.type == "String" || property.type == "Integer")>
            	<label for="${property.name?uncap_first}">${property.name?cap_first}:</label>
        		<input type="text" id="${property.name?uncap_first}" name="${property.name?uncap_first}" value="${'${' + class.name?uncap_first + '.' + property.name + '}'}">
        		<br>
					</#if>
               	</#list>
                <#list referencedProperties as property>
        		<h6>${property.name?cap_first}</h6>
        		<br>
                </#list>
                <br>
                <br>
                <input type="submit" value="Save">
    		</form>
    		<form action="delete/${'${' + class.name?uncap_first + '.id}'}" method="delete">
        		<input type="submit" value="Delete">
    		</form>
        </div>
     </div>
  </body>
</html>