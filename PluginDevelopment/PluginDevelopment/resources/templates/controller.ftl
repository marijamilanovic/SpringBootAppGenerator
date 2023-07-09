package ${class.typePackage};

import java.util.*;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor;

import uns.ftn.mbrs.service.impl.*;
import uns.ftn.mbrs.dto.*;


@RestController
@RequestMapping("/${class.name?lower_case}")
@RequiredArgsConstructor
public class ${class.name?cap_first}Controller {

	private final ${class.name?cap_first}ServiceImpl ${class.name?lower_case}ServiceImpl;
	
    @GetMapping("/{id}")
    public ResponseEntity<${class.name}Dto> findById (@PathVariable Long id) throws Exception {
        Optional<${class.name}Dto> ${class.name?uncap_first}Dto = ${class.name?lower_case}ServiceImpl.findById(id);
        return ${class.name?uncap_first}Dto == null ? new ResponseEntity<>(HttpStatus.NOT_FOUND) : ResponseEntity.ok(${class.name?uncap_first}Dto.get());
    }

    @GetMapping("/all")
    public ResponseEntity<List<${class.name}Dto>> findAll() {
        List<${class.name}Dto> ${class.name?uncap_first}Dtos = ${class.name?lower_case}ServiceImpl.findAll();
        return ${class.name?uncap_first}Dtos == null ? new ResponseEntity<>(HttpStatus.NOT_FOUND) : ResponseEntity.ok(${class.name?uncap_first}Dtos);

    }
    
    @PostMapping("/save")
    public ResponseEntity<${class.name}Dto> save(@RequestBody ${class.name}Dto ${class.name?uncap_first}Dto) {
        ${class.name}Dto saved${class.name}Dto = ${class.name?lower_case}ServiceImpl.save(${class.name?uncap_first}Dto);
        return saved${class.name}Dto == null ? new ResponseEntity<>(HttpStatus.NOT_FOUND) : ResponseEntity.ok(saved${class.name}Dto);
    }
    
    @PostMapping("/update")
    public ResponseEntity<${class.name}Dto> update(@RequestBody ${class.name}Dto ${class.name?uncap_first}Dto) {
        ${class.name}Dto saved${class.name}Dto = ${class.name?lower_case}ServiceImpl.update(${class.name?uncap_first}Dto);
        return saved${class.name}Dto == null ? new ResponseEntity<>(HttpStatus.NOT_FOUND) : ResponseEntity.ok(saved${class.name}Dto);
    }

    @DeleteMapping("/delete/{id}")
    public void delete(@PathVariable Long id){
        ${class.name?lower_case}ServiceImpl.delete(id);
    }
}
