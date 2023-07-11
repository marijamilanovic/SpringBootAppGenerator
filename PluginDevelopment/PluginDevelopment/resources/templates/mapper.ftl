package ${class.typePackage};

import java.util.*;
import uns.ftn.mbrs.model.*;
import uns.ftn.mbrs.dto.*;
import org.mapstruct.InjectionStrategy;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(
	componentModel = "spring",
	injectionStrategy = InjectionStrategy.FIELD
)
public interface ${class.name}Mapper {
  	<#list referencedProperties as property>
		<#if property.upper == 1 && property.oppositeEnd == -1>
	@Mapping(target = "${property.name?uncap_first}", ignore = true)
	    </#if>
    </#list>
	${class.name}Dto ${class.name?substring(0,1)?lower_case}${class.name?substring(1)}To${class.name}Dto(${class.name} ${class.name?substring(0,1)?lower_case}${class.name?substring(1)});
	
	<#list referencedProperties as property>
		<#if property.upper == 1 && property.oppositeEnd == -1>
	@Mapping(target = "${property.name?uncap_first}", ignore = true)
	    </#if>
    </#list>
	${class.name} ${class.name?substring(0,1)?lower_case}${class.name?substring(1)}DtoTo${class.name}(${class.name}Dto ${class.name?substring(0,1)?lower_case}${class.name?substring(1)}Dto);

	<#if class.name?ends_with("y")>
	List<${class.name}Dto> ${class.name?substring(0,1)?lower_case}${class.name?substring(1, class.name?length-1)}iesTo${class.name?substring(0, class.name?length-1)}iesDtos(List<${class.name}> ${class.name?substring(0,1)?lower_case}${class.name?substring(1, class.name?length-1)}ies);
	<#elseif class.name?ends_with("s")>
	List<${class.name}Dto> ${class.name?substring(0,1)?lower_case}${class.name?substring(1)}To${class.name}Dtos(List<${class.name}> ${class.name?substring(0,1)?lower_case}${class.name?substring(1)});
	<#else>
	List<${class.name}Dto> ${class.name?substring(0,1)?lower_case}${class.name?substring(1)}sTo${class.name}Dtos(List<${class.name}> ${class.name?substring(0,1)?lower_case}${class.name?substring(1)}s);
	</#if>
	
	<#if class.name?ends_with("y")>
	List<${class.name}> ${class.name?substring(0,1)?lower_case}${class.name?substring(1, class.name?length-1)}iesDtosTo${class.name?substring(0, class.name?length-1)}ies(List<${class.name}Dto> ${class.name?substring(0,1)?lower_case}${class.name?substring(1, class.name?length-1)}iesDtos);
	<#elseif class.name?ends_with("s")>
	List<${class.name}> ${class.name?substring(0,1)?lower_case}${class.name?substring(1)}DtosTo${class.name}(List<${class.name}Dto> ${class.name?substring(0,1)?lower_case}${class.name?substring(1)}Dtos);
	<#else>
	List<${class.name}> ${class.name?substring(0,1)?lower_case}${class.name?substring(1)}DtosTo${class.name}s(List<${class.name}Dto> ${class.name?substring(0,1)?lower_case}${class.name?substring(1)}sDtos);
	</#if>
}