package ${class.typePackage};

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import uns.ftn.mbrs.model.${class.name};

@Repository
public interface ${class.name}Repository extends JpaRepository<${class.name}, Long> {
<#list properties as property>
	<#if property.upper == 1 && property.name != "id">
	List<${class.name}> findBy<#if property.name != "">${property.name?cap_first}<#else>${property.type}</#if>(${property.type} ${property.name});
	
	</#if>
</#list>
}
