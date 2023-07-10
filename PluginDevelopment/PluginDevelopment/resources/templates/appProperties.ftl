server.port = 8085

spring.datasource.url=jdbc:h2:mem:testdb
spring.datasource.username=root
spring.datasource.password=root
spring.datasource.driverClassName=org.h2.Driver
spring.h2.console.enabled=true
spring.h2.console.path=/h2-console

spring.sql.init.mode=always
spring.jpa.properties.hibernate.format_sql=true
spring.jpa.properties.hibernate.jdbc.lob.non_contextual_creation=true
spring.jpa.database-platform=org.hibernate.dialect.H2Dialect
spring.jpa.hibernate.ddl-auto = create-drop
spring.main.allow-circular-references=true
spring.jpa.show-sql=true
spring.jpa.defer-datasource-initialization=true