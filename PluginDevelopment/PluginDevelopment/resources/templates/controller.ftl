package ${class.typePackage};

import java.util.*;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;

import uns.ftn.mbrs.model.*;
import uns.ftn.mbrs.service.impl.*;
import uns.ftn.mbrs.dto.*;


@RestController
@RequestMapping("/${class.name?lower_case}")
@RequiredArgsConstructor
public class ${class.name?cap_first}Controller {

	@Autowired
	private ${class.name?cap_first}ServiceImpl ${class.name?lower_case}ServiceImpl;
	
    @GetMapping("/{id}")
    public ResponseEntity<${class.name}Dto> getById (@PathVariable Long id) throws Exception {
        ${class.name}Dto ${class.name?uncap_first}Dto = ${class.name?lower_case}ServiceImpl.getById(id);
        return ${class.name?uncap_first}Dto == null ? new ResponseEntity<>(HttpStatus.NOT_FOUND) : ResponseEntity.ok(${class.name?uncap_first}Dto);
    }

    @GetMapping("/all")
    public ResponseEntity<List<${class.name}Dto>> getAll() {
        List<${class.name}Dto> ${class.name?uncap_first}Dtos = ${class.name?lower_case}ServiceImpl.getAll();
        return ${class.name?uncap_first}Dtos == null ? new ResponseEntity<>(HttpStatus.NOT_FOUND) : ResponseEntity.ok(${class.name?uncap_first}Dtos);

    }
    
    @PostMapping("/save")
    public ResponseEntity<${class.name}Dto> save(@RequestBody ${class.name}Dto ${class.name?uncap_first}Dto}) {
        ${class.name}Dto ${class.name?uncap_first}Dto = ${class.name?lower_case}ServiceImpl.save(${class.name?uncap_first}Dto);
        return ${class.name?uncap_first}Dto == null ? new ResponseEntity<>(HttpStatus.NOT_FOUND) : ResponseEntity.ok(${class.name?uncap_first}Dto);
    }
    
    @PostMapping("/update/{id}")
    public ResponseEntity<${class.name}Dto> update(@PathVariable Long id, @RequestBody ${class.name}Dto ${class.name?uncap_first}Dto) {
        ${class.name}Dto ${class.name?uncap_first}Dto = ${class.name?lower_case}ServiceImpl.update(id, ${class.name?uncap_first}Dto);
        return ${class.name?uncap_first}Dto == null ? new ResponseEntity<>(HttpStatus.NOT_FOUND) : ResponseEntity.ok(${class.name?uncap_first}Dto);
    }

    @DeleteMapping("/delete/{id}")
    public void delete(@PathVariable Long id){
        ${class.name?lower_case}ServiceImpl.delete(id);
    }
}
