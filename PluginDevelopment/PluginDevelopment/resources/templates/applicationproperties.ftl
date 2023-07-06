server.port = <#if port??>{$port}<#else>8085</#if>

# Database
spring.datasource.driverClassName=com.mysql.cj.jdbc.Driver
spring.datasource.initialization-mode=always
spring.datasource.platform=mysql
spring.datasource.url=jdbc:mysql://localhost:3306/<#if databaseName??>${databaseName}<#else>mbrs</#if>

spring.datasource.username=<#if databaseUsername??>${databaseUsername}<#else>admin</#if>
spring.datasource.password=<#if databasePassword??>${databasePassword}<#else>root</#if>

spring.jpa.show-sql = true
spring.jpa.generate-ddl=true

spring.jpa.hibernate.ddl-auto=create-drop
