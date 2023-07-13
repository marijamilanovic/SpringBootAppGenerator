package ${class.typePackage};

import java.util.*;

import uns.ftn.mbrs.model.*;
import uns.ftn.mbrs.dto.*;


public interface ${class.name}Service extends ManualChangesService {
	String save(${class.name}Dto ${class.name?uncap_first}Dto, String parent, Integer id);
	
	String update(${class.name} new${class.name});
	
	List<${class.name}> findAll();
	
	${class.name} findById(Integer id);
	
	String delete(Integer id);
	
	<#list properties as property>
	        <#if property.name != "id" && property.upper == 1>
		        <#if property.type == "date" || property.type == "double">
    	List<${class.name}> findBy${property.name?cap_first}(${property.type?cap_first} ${property.name});
			        <#else>
    	List<${class.name}> findBy${property.name?cap_first}(${property.type} ${property.name});
			    </#if>
	    
	        </#if>
	</#list>
	
}
