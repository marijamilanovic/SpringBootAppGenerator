package ${class.typePackage};

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.*;

import uns.ftn.mbrs.model.*;

@Repository
public interface ${class.name}Repository extends JpaRepository<${class.name}, Integer> {

<#list properties as property>
	<#if property.upper == 1 && property.name != "id">
		<#if property.type == "date" || property.type == "double">
    	List<${class.name}> findBy<#if property.name != "">${property.name?cap_first}<#else>${property.type}</#if>(${property.type?cap_first} ${property.name});
			<#else>
    	List<${class.name}> findBy<#if property.name != "">${property.name?cap_first}<#else>${property.type}</#if>(${property.type} ${property.name});
	    </#if>
	
	</#if>
</#list>
}
