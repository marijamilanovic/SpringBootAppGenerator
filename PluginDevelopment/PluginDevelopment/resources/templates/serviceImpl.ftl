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
	
	@Override
	public ${class.name}Dto save(${class.name}Dto new${class.name}Dto) {
		${class.name} saved${class.name} = ${class.name?uncap_first}Repository.save(${class.name?uncap_first}Mapper.${class.name?uncap_first}DtoTo${class.name}(new${class.name}Dto));
		return ${class.name?uncap_first}Mapper.${class.name?uncap_first}To${class.name}Dto(saved${class.name});
	}

	@Override
	public ${class.name}Dto update(${class.name}Dto new${class.name}Dto) {
		${class.name} saved${class.name} = ${class.name?uncap_first}Repository.save(${class.name?uncap_first}Mapper.${class.name?uncap_first}DtoTo${class.name}(new${class.name}Dto));
		return ${class.name?uncap_first}Mapper.${class.name?uncap_first}To${class.name}Dto(saved${class.name});
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
	public Optional<${class.name}Dto> findById(Integer id) {
		Optional<${class.name}> ${class.name?uncap_first} = ${class.name?uncap_first}Repository.findById(id);
		return ${class.name?uncap_first}.map(${class.name?uncap_first}Mapper::${class.name?uncap_first}To${class.name}Dto);
	}
	
	@Override
	public void delete(Integer id) {
		Optional<${class.name}> ${class.name?uncap_first} = ${class.name?uncap_first}Repository.findById(id);
		if(${class.name?uncap_first}.isPresent()){
			${class.name?uncap_first}Repository.delete(${class.name?uncap_first}.get());
		}
		throw new EntityNotFoundException("${class.name} not found with id: " + id);
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
}