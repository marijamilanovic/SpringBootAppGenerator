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
    private List<${property.type?cap_first}Dto> ${property.name?uncap_first};
    	<#else>
    private Integer ${property.name?uncap_first}Id;
    	</#if>
    
    </#list>
}