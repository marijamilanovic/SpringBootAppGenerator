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
    public String findById (@PathVariable Long id, Model model) throws Exception {
        Optional<${class.name}Dto> ${class.name?uncap_first}Dto = ${class.name?uncap_first}ServiceImpl.findById(id);
        model.addAttribute("${class.name?uncap_first}", ${class.name?uncap_first}Dto);
        
		return "${class.name}";
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
    public String update(@RequestBody ${class.name}Dto ${class.name?uncap_first}Dto) {
        ${class.name}Dto saved${class.name}Dto = ${class.name?uncap_first}ServiceImpl.update(${class.name?uncap_first}Dto);
		return "${class.name}";
    }

    @DeleteMapping("/delete/{id}")
    public void delete(@PathVariable Long id){
        ${class.name?uncap_first}ServiceImpl.delete(id);
    }

}
