package ${class.typePackage};

import javax.persistence.*;
import java.util.*;

<#list imports as import>import ${import};
</#list>

@Entity 
<#if class.tableName??>
@Table(name="${class.tableName}")
</#if>
@Getter
@Setter
@RequiredArgsConstructor
${class.visibility} class ${class.name}{  
<#list properties as property>

	<#if property.upper == 1 >   
    ${property.visibility} ${property.type} ${property.name};
    <#elseif property.upper == -1 > 
    ${property.visibility} Set<${property.type}> ${property.name} = new HashSet<${property.type}>();
    <#else>   
    	<#list 1..property.upper as i>
    ${property.visibility} ${property.type} ${property.name}${i};
		</#list>  
    </#if>     
</#list>
<#list persistentProperties as prop>
<#if prop.strategy??>

	@Id
	<#if prop.strategy == "AUTO" || prop.strategy  == "IDENTITY" >
	@GeneratedValue(strategy = GenerationType.${prop.strategy})
<#elseif prop.strategy == "SEQUENCE">
	@GeneratedValue(strategy = GenerationType.${prop.strategy}, generator = "${class.name?lower_case}_generator")
	@SequenceGenerator(name = "${class.name?lower_case}_generator", sequenceName = "${class.name?lower_case}_seq")		
</#if>
<#else>

	@Column(name = "${prop.name?lower_case}", <#if (prop.length)??>length = ${prop.length}, </#if><#if (prop.precision)??> precision = ${prop.precision}, </#if>nullable = <#if prop.lower == 0>false<#else>true</#if>, unique = <#if prop.isUnique>true<#else>false</#if>)
</#if>
	${prop.visibility} ${prop.type} ${prop.name};
</#list>

<#list referencedProperties as property>

<#if property.upper == -1 && property.oppositeEnd == -1>
    @ManyToMany
	<#elseif property.upper == -1 && property.oppositeEnd == 1>
    @OneToMany
	<#elseif property.upper == 1 && property.oppositeEnd== -1>
    @ManyToOne
	<#else>
    @OneToOne
	</#if>
    <#if (property.fetchType)?? || (property.cascade)?? || (property.mappedBy)?? || (property.optional)?? >
    (
		<#if (property.cascade)??>
        cascade = CascadeType.${property.cascade}
		</#if>
		<#if (property.fetchType)??>
        fetch = FetchType.${property.fetchType}
			</#if>
		<#if (property.mappedBy)??>
			<#lt><#if (property.cascade)?? || (property.fetchType)??>,
			</#if>
        mappedBy = "${property.mappedBy}"
		</#if>
    )
	</#if>
	<#if (property.joinTable)??>
    @JoinTable(name="${property.joinTable}")
	</#if>
	<#if (property.joinColumn)??>
    @JoinColumn(name="${property.joinColumn}")
	</#if>
    ${property.visibility} <#if property.upper == -1>Set<</#if>${property.type?cap_first}<#if property.upper == -1>></#if> ${property.name?uncap_first};	
</#list>
}