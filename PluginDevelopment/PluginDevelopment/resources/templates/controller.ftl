package ${class.typePackage};

import java.util.*;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor;
import org.springframework.ui.Model;

import ${class.typePackage?keep_before(".")}.model.${class.name};
import ${class.typePackage?keep_before(".")}.service.${class.name}Service;

@RestController
@RequestMapping("/${class.name?lower_case}")
@RequiredArgsConstructor
public class ${class.name?cap_first}Controller {

	
	@Autowired
	private ${class.name?cap_first}Service ${class.name?lower_case}Service;
	
    @GetMapping("/{id}")
    public ResponseEntity<Optional<${class.name}Dto>> getById (@PathVariable Long id) throws Exception {
        ${class.name} ${class.name?uncap_first}Dto = ${class.name?lower_case}Service.getById(id);
        return ${class.name?uncap_first}Dto == null ? new ResponseEntity<>(HttpStatus.NOT_FOUND) : ResponseEntity.ok(${class.name?uncap_first}Dto);
    }

    @GetMapping("/all")
    public ResponseEntity<List<Optional<${class.name}Dto>>> getAll() {
        List<${class.name}Dto> ${class.name?uncap_first}Dtos = ${class.name?lower_case}Service.getAll();
        return ${class.name?uncap_first}Dtos == null ? new ResponseEntity<>(HttpStatus.NOT_FOUND) : ResponseEntity.ok(${class.name?uncap_first}Dtos);

    }
    
    @PostMapping("/save")
    public ResponseEntity<Optional<${class.name}Dto>> save(@RequestBody ${class.name} ${class.name?uncap_first}}) {
        ${class.name}Dto ${class.name?uncap_first}Dto = ${class.name?lower_case}Service.save(${class.name?uncap_first});
        return ${class.name?uncap_first}Dto == null ? new ResponseEntity<>(HttpStatus.NOT_FOUND) : ResponseEntity.ok(${class.name?uncap_first}Dto);
    }
    
    @PostMapping("/update/{id}")
    public ResponseEntity<Optional<${class.name}Dto>> update(@PathVariable Long id, @RequestBody ${class.name} ${class.name?uncap_first}) {
        ${class.name}Dto ${class.name?uncap_first}Dto = ${class.name?lower_case}Service.update(id, ${class.name?uncap_first});
        return ${class.name?uncap_first}Dto == null ? new ResponseEntity<>(HttpStatus.NOT_FOUND) : ResponseEntity.ok(${class.name?uncap_first}Dto);
    }

    @DeleteMapping("/delete/{id}")
    public void delete(@PathVariable Long id){
        ${class.name?lower_case}Service.delete(id);
    }
}
