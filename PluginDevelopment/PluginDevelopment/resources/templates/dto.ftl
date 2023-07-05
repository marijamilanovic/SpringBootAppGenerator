package ${class.typePackage};

import java.util.*;

<#list imports as import>
import ${import}Dto;
</#list>

@Getter
@Setter
@RequiredArgsConstructor
public class ${class.name}Dto {
    <#list properties as property>
    <#if property.type == "date">
	private Date ${property.name};
	<#else>
	private ${property.type} ${property.name};
	</#if>
    
    </#list>
    <#list persistentProperties as persistenProperty>
    <#if persistenProperty.type == "date">
	private Date ${persistenProperty.name};
	<#else>
	private ${persistenProperty.type} ${persistenProperty.name};
	</#if>
    
    </#list>
    <#list referencedProperties as property>
    private <#if property.upper == -1>List<</#if>${property.type?cap_first}Dto<#if property.upper == -1>></#if> ${property.name?uncap_first};
    
    </#list>
}