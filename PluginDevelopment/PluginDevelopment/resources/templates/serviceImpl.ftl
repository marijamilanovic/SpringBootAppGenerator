package ${class.typePackage};

import javax.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.*;

import uns.ftn.mbrs.model.*;
import uns.ftn.mbrs.service.*;
import uns.ftn.mbrs.repository.*;
import uns.ftn.mbrs.mappers.*;
import uns.ftn.mbrs.dto.*;

@Service
@RequiredArgsConstructor
public class ${class.name}ServiceImpl implements ${class.name}Service {

	private final ${class.name}Repository ${class.name?uncap_first}Repository;
	private final ${class.name}Mapper ${class.name?uncap_first}Mapper;
	<#list referencedProperties as property>
		<#if property.upper == 1 && property.oppositeEnd == -1>
	private final ${property.name?cap_first}ServiceImpl ${property.name?uncap_first}ServiceImpl;
	    </#if>
    </#list>
	
	@Override
	public String save(${class.name}Dto ${class.name?uncap_first}Dto, String parent, Integer id) {
		${class.name?uncap_first}Dto.setId(null);
		${class.name} ${class.name?uncap_first} = ${class.name?uncap_first}Mapper.${class.name?substring(0,1)?lower_case}${class.name?substring(1)}DtoTo${class.name}(${class.name?uncap_first}Dto);
    	<#list referencedProperties as property>
			<#if property.upper == 1 && property.oppositeEnd == -1>
		if (parent.equals(${'"' + property.type?uncap_first+ '"'})) {
			${class.name?uncap_first}.set${property.name?cap_first}(${property.name?uncap_first}ServiceImpl.findById(id));
		}
	    	</#if>
    	</#list>
		${class.name?uncap_first}Repository.save(${class.name?uncap_first});
		return "redirect:/";
	}

	@Override
	public String update(${class.name} new${class.name}) {
		Optional<${class.name}> ${class.name?uncap_first} = ${class.name?uncap_first}Repository.findById(new${class.name}.getId());
		if(${class.name?uncap_first}.isPresent()){
			<#list referencedProperties as property>
				<#if property.upper == 1 && property.oppositeEnd == -1>
			new${class.name}.set${property.name?cap_first}(${property.name?uncap_first}ServiceImpl.findById(${class.name?uncap_first}.get().get${property.name?cap_first}().getId()));
		    	</#if>
    		</#list>
    		${class.name?uncap_first}Repository.save(new${class.name});
			return "redirect:/";
		} else {
			throw new EntityNotFoundException("${class.name} not found with id: " + new${class.name}.getId());
		}
	}
	
	@Override
	public List<${class.name}> findAll() {
	<#if class.name?ends_with("y")>
		List<${class.name}> ${class.name?substring(0,1)?lower_case}${class.name?substring(1, class.name?length-1)}ies = ${class.name?uncap_first}Repository.findAll();
		return ${class.name?substring(0,1)?lower_case}${class.name?substring(1, class.name?length-1)}ies;
	<#elseif class.name?ends_with("s")>
		List<${class.name}> ${class.name?uncap_first} = ${class.name?uncap_first}Repository.findAll();
		return ${class.name?uncap_first};
	<#else>
		List<${class.name}> ${class.name?uncap_first}s = ${class.name?uncap_first}Repository.findAll();
		return ${class.name?uncap_first}s;
	</#if>
	}
	
	@Override
	public ${class.name} findById(Integer id) {
		Optional<${class.name}> ${class.name?uncap_first} = ${class.name?uncap_first}Repository.findById(id);
		return ${class.name?uncap_first}.get();
	}
	
	@Override
	public String delete(Integer id) {
		Optional<${class.name}> ${class.name?uncap_first} = ${class.name?uncap_first}Repository.findById(id);
		if(${class.name?uncap_first}.isPresent()){
			${class.name?uncap_first}Repository.delete(${class.name?uncap_first}.get());
			return "redirect:/";
		} else {
			throw new EntityNotFoundException("${class.name} not found with id: " + id);
		}
	}
	
	<#list properties as property>
		<#if property.name != "id" && property.upper == 1>
	@Override
			<#if property.type == "date" || property.type == "double">
    	public List<${class.name}> findBy${property.name?cap_first}(${property.type?cap_first} ${property.name}){
				<#else>
    	public List<${class.name}> findBy${property.name?cap_first}(${property.type} ${property.name}){
		    </#if>
		return ${class.name?uncap_first}Repository.findBy${property.name?cap_first}(${property.name});
	}
		</#if>
	</#list>
	
	@Override
	public void manualFunction() {
		System.out.println("Function from");
	}
}