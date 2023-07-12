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

<!DOCTYPE html>
<html>
  <body>
    <%@include file="navbar.jsp"%>
	<div class="container">
		<br/>
        <h3 class="text-center">${class.name?cap_first} Overview</h3>
        <div class="form-group row">
    <label for="staticEmail" class="col-sm-2 col-form-label">Email</label>
	    <div class="col-sm-10">
	      <input type="text" readonly class="form-control-plaintext" id="staticEmail" value="email@example.com">
	    </div>
  	</div>
	<div class="form-group row">
		<#list persistentProperties as property>
        	<#if property.name != "id" && (property.type == "String" || property.type == "Integer")>
    	<label for="${property.name?uncap_first}" class="col-sm-2 col-form-label">${property.name?cap_first}:</label>
    	<div class="col-sm-10">
			<input class="form-control" readonly type="text" id="${property.name?uncap_first}" name="${property.name?uncap_first}" value="${'${' + class.name?uncap_first + '.' + property.name + '}'}">
		</div>
		<br>
			</#if>
       	</#list>
  	</div>
    <div>
		<table id="table_id" class="table table-sm table-hover table-bordered text-center mt-3">
        	<thead>
            	<tr>
                	<#list referencedProperties as property>
                		<th>${property.name?cap_first}</th>
                    </#list>
            	</tr>
            </thead>
            <tbody>
            	<c:forEach items="${ "${" + class.name?uncap_first + "List" + "}" }" var="${class.name?uncap_first}">
            	<tr onclick="redirectToPage(${ "${" + class.name?uncap_first + ".id" +"}" })">
        		<#list referencedProperties as property>
            		 <td onclick="redirectToPage(this)">
	                   <c:forEach items="${ "${" + class.name?uncap_first + "." + property.name?uncap_first + "}" }" var="${property.name?uncap_first}">
	                 		<label>${property.name?cap_first} </label>
	                   </c:forEach>
	                 </td>
	             </#list>
            	</tr>
            	</c:forEach>
            </tbody>
         </table>
        </div>
     </div>
     </div>
     <script>
	  function redirectToPage(cell) {
	    var rowId = cell.parentNode.getAttribute('data-row-id');
	    var columnValue = cell.innerHTML;
	    window.location.href = '/'+ columnValue + '?id=' + rowId;
	  }
	</script>
  </body>
</html>