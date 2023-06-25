package ${enum.typePackage};

public enum ${enum.name}{
   <#list values as enumeration>
    ${enumeration}<#sep>,</#sep>
</#list>
}