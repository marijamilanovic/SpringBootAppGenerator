package ${class.typePackage};

import java.util.*;

<#list imports as import>
import ${import};
</#list>

@Getter
@Setter
@RequiredArgsConstructor
public class ${class.name}DTO {
    <#list properties as property>
    private ${property.type} ${property.name};
    
    </#list>
     <#list persistentProperties as persistenProperty>
    private ${persistenProperty.type} ${persistenProperty.name};
    
    </#list>
    <#list referencedProperties as property>
    private <#if property.upper == -1>Set<</#if>${property.type?cap_first}DTO<#if property.upper == -1>></#if> ${property.name?uncap_first};
    </#list>
}