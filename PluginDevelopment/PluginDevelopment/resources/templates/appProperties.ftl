server.port = 8085

spring.datasource.url=jdbc:h2:mem:testdb
spring.datasource.username=root
spring.datasource.password=root
spring.datasource.driver-class-name=org.h2.Driver

spring.sql.init.mode=always
spring.jpa.properties.hibernate.format_sql=true
spring.jpa.properties.hibernate.jdbc.lob.non_contextual_creation=true
spring.jpa.hibernate.ddl-auto = create-drop
spring.main.allow-circular-references=true

spring.mvc.view.prefix=/WEB-INF/views/
spring.mvc.view.suffix=.jsp