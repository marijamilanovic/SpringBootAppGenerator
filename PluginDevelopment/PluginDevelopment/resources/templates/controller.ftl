package ${class.typePackage};

import java.util.*;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor;
import org.springframework.ui.Model;
import uns.ftn.mbrs.service.impl.*;
import uns.ftn.mbrs.dto.*;
import uns.ftn.mbrs.model.*;
import org.springframework.stereotype.Controller;


@Controller
@RequestMapping("/${class.name?lower_case}")
@RequiredArgsConstructor
public class ${class.name?cap_first}Controller {

	private final ${class.name?cap_first}ServiceImpl ${class.name?uncap_first}ServiceImpl;
    
    @GetMapping("/{id}")
    public String findById(@PathVariable Integer id, Model model) throws Exception {
        Optional<${class.name}Dto> ${class.name?uncap_first}Dto = ${class.name?uncap_first}ServiceImpl.findById(id);
        if (${class.name?uncap_first}Dto.isPresent()) {
            model.addAttribute("${class.name?lower_case}", ${class.name?uncap_first}Dto.get());
        }
        return "${class.name?cap_first}Form";
    }

    @GetMapping("/all")
    public ResponseEntity<List<${class.name}Dto>> findAll() {
        List<${class.name}Dto> ${class.name?uncap_first}Dtos = ${class.name?uncap_first}ServiceImpl.findAll();
        return ${class.name?uncap_first}Dtos == null ? new ResponseEntity<>(HttpStatus.NOT_FOUND) : ResponseEntity.ok(${class.name?uncap_first}Dtos);

    }
    
    @PostMapping("/save")
    public ResponseEntity<${class.name}Dto> save(@RequestBody ${class.name}Dto ${class.name?uncap_first}Dto) {
        ${class.name}Dto saved${class.name}Dto = ${class.name?uncap_first}ServiceImpl.save(${class.name?uncap_first}Dto);
        return saved${class.name}Dto == null ? new ResponseEntity<>(HttpStatus.NOT_FOUND) : ResponseEntity.ok(saved${class.name}Dto);
    }
    
    @PostMapping("/update")
    public ResponseEntity<${class.name}Dto> update(@RequestBody ${class.name}Dto ${class.name?uncap_first}Dto) {
        ${class.name}Dto saved${class.name}Dto = ${class.name?uncap_first}ServiceImpl.update(${class.name?uncap_first}Dto);
        return saved${class.name}Dto == null ? new ResponseEntity<>(HttpStatus.NOT_FOUND) : ResponseEntity.ok(saved${class.name}Dto);
    }

    @DeleteMapping("/delete/{id}")
    public void delete(@PathVariable Integer id){
        ${class.name?uncap_first}ServiceImpl.delete(id);
    }

     private void initModel(Model model) {
    	model.addAttribute("${class.name?uncap_first}", new ${class.name}());
    	model.addAttribute("${class.name?uncap_first}List", ${class.name?uncap_first}ServiceImpl.findAll());
    }
}
