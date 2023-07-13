package ${class.typePackage};

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor;
import org.springframework.ui.Model;
import uns.ftn.mbrs.service.impl.*;
import uns.ftn.mbrs.dto.*;
import uns.ftn.mbrs.model.*;
import uns.ftn.mbrs.mappers.*;
import org.springframework.stereotype.Controller;
import java.util.*;


@Controller
@RequestMapping("/${class.name?lower_case}")
@RequiredArgsConstructor
public class ${class.name?cap_first}Controller {

	private final ${class.name?cap_first}ServiceImpl ${class.name?uncap_first}ServiceImpl;
	private final ${class.name}Mapper ${class.name?uncap_first}Mapper;
	<#list referencedProperties as property>
	private final ${property.type?cap_first}ServiceImpl ${property.type?uncap_first}ServiceImpl;
    </#list>
    
    @GetMapping("/{id}")
    public String findById(@PathVariable Integer id, Model model) throws Exception {
        ${class.name} ${class.name?uncap_first} = ${class.name?uncap_first}ServiceImpl.findById(id);
        ${class.name}Dto ${class.name?uncap_first}Dto = ${class.name?uncap_first}Mapper.${class.name?substring(0,1)?lower_case}${class.name?substring(1)}To${class.name}Dto(${class.name?uncap_first});
        <#list referencedProperties as property>
        List<${property.type}> ${property.type?uncap_first}List = ${property.type?uncap_first}ServiceImpl.findAll();
    	</#list>
        if (${class.name?uncap_first} != null) {
            model.addAttribute("${class.name?uncap_first}Dto", ${class.name?uncap_first}Dto);
            <#list referencedProperties as property>
        	model.addAttribute("${property.type?uncap_first}List", ${property.type?uncap_first}List);
    			<#if property.upper == 1 && property.oppositeEnd == -1>
			model.addAttribute("${property.type?uncap_first}Id", ${class.name?uncap_first}.get${property.type?cap_first}().getId());
	    		</#if>
    		</#list>
        }
        return "${class.name?cap_first}Form";
    }
    
    @GetMapping("/overview/{id}")
    public String overviewObjectById(@PathVariable Integer id, Model model) throws Exception {
        ${class.name} ${class.name?uncap_first} = ${class.name?uncap_first}ServiceImpl.findById(id);
        if (${class.name?uncap_first} != null) {
            model.addAttribute("${class.name?lower_case}", ${class.name?uncap_first});
        }
        return "${class.name?cap_first}Overview";
    }
    
    
    @GetMapping("/all")
    public String findAll(Model model) {
		model.addAttribute("${class.name?uncap_first}", new ${class.name}());
    	model.addAttribute("${class.name?uncap_first}List", ${class.name?uncap_first}ServiceImpl.findAll());
    	
    	return "${class.name}ListOverview";
    }
    
    @PostMapping("/save")
    public String save(@ModelAttribute ${class.name}Dto ${class.name?uncap_first}Dto,
    					@RequestParam(value = "parent", required = false) String parent,
                        @RequestParam(value = "id", required = false) Integer id) {
        return ${class.name?uncap_first}ServiceImpl.save(${class.name?uncap_first}Dto, parent, id);
    }
    
    @PostMapping("/update")
    public String update(@ModelAttribute ${class.name} ${class.name?uncap_first}) {
        return ${class.name?uncap_first}ServiceImpl.update(${class.name?uncap_first});
    }

    @PostMapping("/delete/{id}")
    public String delete(@PathVariable Integer id){
        return ${class.name?uncap_first}ServiceImpl.delete(id);
    }

     private void initModel(Model model) {
    	model.addAttribute("${class.name?uncap_first}", new ${class.name}());
    	model.addAttribute("${class.name?uncap_first}List", ${class.name?uncap_first}ServiceImpl.findAll());
    }
    
    @GetMapping("/new")
    public String create(@RequestParam(value = "parent", required = false) String parent,
                         @RequestParam(value = "id", required = false) Integer id) throws Exception {
        return "new${class.name?cap_first}Form";
    }
}
