package ${class.typePackage};

import java.util.*;

<#list imports as import>
import ${import};
</#list>
import org.mapstruct.InjectionStrategy;
import org.mapstruct.Mapper;

@Mapper(
	componentModel = "spring",
	injectionStrategy = InjectionStrategy.FIELD
)
public interface ${class.name}Mapper {
	${class.name}Dto ${class.name?substring(0,1)?lower_case}${class.name?substring(1)}To${class.name}Dto(${class.name} ${class.name?substring(0,1)?lower_case}${class.name?substring(1)});
	
	${class.name} ${class.name?substring(0,1)?lower_case}${class.name?substring(1)}To${class.name}Dto(${class.name}Dto ${class.name?substring(0,1)?lower_case}${class.name?substring(1)}Dto);

	<#if class.name?ends_with("y")>
	List<${class.name}DTO> ${class.name?substring(0,1)?lower_case}${class.name?substring(1, class.name?length-1)}iesTo${class.name?substring(0, class.name?length-1)}iesDTOs(List<${class.name}> ${class.name?substring(0,1)?lower_case}${class.name?substring(1, class.name?length-1)}ies);
	<#elseif class.name?ends_with("s")>
	List<${class.name}DTO> ${class.name?substring(0,1)?lower_case}${class.name?substring(1)}To${class.name}DTOs(List<${class.name}> ${class.name?substring(0,1)?lower_case}${class.name?substring(1)});
	<#else>
	List<${class.name}DTO> ${class.name?substring(0,1)?lower_case}${class.name?substring(1)}sTo${class.name}DTOs(List<${class.name}> ${class.name?substring(0,1)?lower_case}${class.name?substring(1)}s);
	</#if>
	
	<#if class.name?ends_with("y")>
	List<${class.name}> ${class.name?substring(0,1)?lower_case}${class.name?substring(1, class.name?length-1)}iesDtosTo${class.name?substring(0, class.name?length-1)}ies(List<${class.name}DTO> ${class.name?substring(0,1)?lower_case}${class.name?substring(1, class.name?length-1)}iesDtos);
	<#elseif class.name?ends_with("s")>
	List<${class.name}> ${class.name?substring(0,1)?lower_case}${class.name?substring(1)}DTOsTo${class.name}(List<${class.name}DTO> ${class.name?substring(0,1)?lower_case}${class.name?substring(1)}Dtos);
	<#else>
	List<${class.name}> ${class.name?substring(0,1)?lower_case}${class.name?substring(1)}DTOsTo${class.name}s(List<${class.name}DTO> ${class.name?substring(0,1)?lower_case}${class.name?substring(1)}sDtos);
	</#if>
}