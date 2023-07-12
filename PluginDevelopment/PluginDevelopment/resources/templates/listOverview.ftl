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
            <h3 class="text-center">List of ${class.name?cap_first}</h3>
            <div>
                 <a class="btn btn-outline-primary btn-sm float-right mb-3" href="/${class.name?uncap_first}/new">Add new ${class.name}</a>
            </div>
            <div>
                 <table id="table_id" class="table table-sm table-hover table-bordered text-center mt-3">
                    <thead>
                    	<tr>
                        	<#list properties as property>
                        	<th>${property.name?cap_first}</th>
                        	</#list>
                        	<#list persistentProperties as property>
                    		<th>${property.name?cap_first}</th>
                        	</#list>
                    	</tr>
                    </thead>
                    <tbody>
                    	<c:forEach items="${ "${" + class.name?uncap_first + "List" + "}" }" var="${class.name?uncap_first}">
                    	<tr onclick="redirectToPage(${ "${" + class.name?uncap_first + ".id" +"}" })">
                		<#list properties as property>
                    		<td>"${ "${" + class.name?uncap_first + "." + property.name?uncap_first + "}" }"</td>
                		</#list>
                		 <#list persistentProperties as property>
                		 <td>
		                 	<label>${"${" + class.name?uncap_first + "." + property.name + "}"} </label>
		                 </td>
		                 </#list>
                    	</tr>
                    	</c:forEach>
                    </tbody>
                 </table>
            </div>
         </div>
	<script>
	  function redirectToPage(rowId) {
		window.location.href = '/${class.name?uncap_first}/' + rowId;
	  }
	</script>
  </body>
</html>
