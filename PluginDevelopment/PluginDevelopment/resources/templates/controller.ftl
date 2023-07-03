package ${class.typePackage};

import java.util.List;

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
    private final ${class.name?cap_first}Service ${serviceName}?lower_case;
    
    @GetMapping("/{id}")
    public ResponseEntity<Optional<${class.name}Dto>> getById (@PathVariable Long id) throws Exception {
        ${class.name} ${class.name?uncap_first} = ${serviceName}?lower_case.getById(id);
        return ${class.name?uncap_first};
        return ${class.name?uncap_first} == null ? new ResponseEntity<>(HttpStatus.NOT_FOUND) : ResponseEntity.ok(${class.name?uncap_first});
    }

    @GetMapping("/all")
    public ResponseEntity<List<Optional<${class.name}Dto>>> getAll() {
        List<${class.name}> ${class.name?uncap_first}s = ${serviceName}?lower_case.getAll();
        return ${class.name?uncap_first}s == null ? new ResponseEntity<>(HttpStatus.NOT_FOUND) : ResponseEntity.ok(${class.name?uncap_first}s);

    }
    
    @PostMapping("/save")
    public ResponseEntity<Optional<${class.name}Dto>> save(@RequestBody ${class.name} ${class.name?uncap_first}}) {
        ${class.name} ${class.name} = ${serviceName}?lower_case.save(${class.name?uncap_first});
        return ${class.name?uncap_first} == null ? new ResponseEntity<>(HttpStatus.NOT_FOUND) : ResponseEntity.ok(${class.name?uncap_first});
    }
    
    @PostMapping("/update/{id}")
    public ResponseEntity<Optional<${class.name}Dto>> update(@PathVariable Long id, @RequestBody ${class.name} ${class.name?uncap_first}) {
        ${class.name} ${class.name} = ${serviceName}?lower_case.update(id, ${class.name?uncap_first});
        return ${class.name?uncap_first} == null ? new ResponseEntity<>(HttpStatus.NOT_FOUND) : ResponseEntity.ok(${class.name?uncap_first});
    }

    @DeleteMapping("/delete/{id}")
    public void delete(@PathVariable Long id){
        ${serviceName}?lower_case.delete(id);
    }
}
