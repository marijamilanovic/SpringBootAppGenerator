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
        ${class.name} ${class.name?uncap_first} = ${class.name?uncap_first}ServiceImpl.findById(id);
        if (${class.name?uncap_first} != null) {
            model.addAttribute("${class.name?lower_case}", ${class.name?uncap_first});
        }
        return "${class.name?cap_first}Form";
    }

    @GetMapping("/all")
    public String findAll(Model model) {
		model.addAttribute("${class.name?uncap_first}", new ${class.name}());
    	model.addAttribute("${class.name?uncap_first}List", ${class.name?uncap_first}ServiceImpl.findAll());
    	
    	return "${class.name}ListOverview";
    }
    
    @PostMapping("/save")
    public String save(@RequestBody ${class.name}Dto ${class.name?uncap_first}Dto) {
        ${class.name}Dto saved${class.name}Dto = ${class.name?uncap_first}ServiceImpl.save(${class.name?uncap_first}Dto);
		return "${class.name}";
    }
    
    @PostMapping("/update")
    public ResponseEntity<${class.name}Dto> update(@ModelAttribute ${class.name}Dto ${class.name?uncap_first}Dto) {
        ${class.name}Dto saved${class.name}Dto = ${class.name?uncap_first}ServiceImpl.update(${class.name?uncap_first}Dto);
		return "${class.name}";
    }

    @PostMapping("/delete/{id}")
    public String delete(@PathVariable Integer id){
        return ${class.name?uncap_first}ServiceImpl.delete(id);
    }

}
