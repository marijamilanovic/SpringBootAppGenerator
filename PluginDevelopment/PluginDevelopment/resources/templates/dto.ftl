package ${class.typePackage};

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import java.util.*;

import lombok.Getter;
import lombok.Setter;
import lombok.RequiredArgsConstructor;

import uns.ftn.mbrs.model.*;
import uns.ftn.mbrs.dto.*;

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
    	<#if property.upper == -1>
    // for drop-down
    private List<${property.type?cap_first}Dto> ${property.type?uncap_first}List;
		    <#if property.type?ends_with("y")>
	private List<${property.type}> ${property.type?substring(0,1)?lower_case}${property.type?substring(1, property.type?length-1)}ies;
			<#elseif property.type?ends_with("s")>
	private List<${property.type}> ${property.type?uncap_first};
			<#else>
	private List<${property.type}> ${property.type?uncap_first}s;
			</#if>
    	<#else>
    // for drop-down
    private List<${property.type?cap_first}Dto> ${property.name?uncap_first}List;	
    
    private Integer ${property.name?uncap_first}Id;
    	</#if>
    
    </#list>
}