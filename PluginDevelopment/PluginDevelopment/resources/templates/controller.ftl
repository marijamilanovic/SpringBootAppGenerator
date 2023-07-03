package ${class.typePackage};

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import ${class.typePackage?keep_before(".")}.model.${class.name};
import ${class.typePackage?keep_before(".")}.service.${class.name}Service;

@RestController
@RequestMapping("/${class.name?lower_case}")
@RequiredArgsConstructor
public class ${class.name}Controller {

    private final ${class.name?cap_first}Service ${serviceName}?lower_case;
    
    @GetMapping("/{id}")
    public <${class.name}> getById (@PathVariable Long id) throws Exception {
        ${class.name} ${class.name?uncap_first} = ${serviceName}?lower_case.getById(id);
        return ${class.name?uncap_first};
    }

    @GetMapping("/all")
    public <List<${class.name}> getAll() {
        List<${class.name}> ${class.name?uncap_first}s = ${serviceName}?lower_case.getAll();
        return "${class.name}s";
    }
    
    @PostMapping("/save")
    public <${class.name}> save(${class.name} ${class.name?uncap_first}}) {
        ${class.name} ${class.name} = ${serviceName}?lower_case.save(${class.name?uncap_first});
        return "${class.name}";
    }
    
    @PostMapping("/update/{id}")
    public ${class.name} update(@PathVariable Long id, ${class.name} ${class.name?uncap_first}) {
        ${class.name} ${class.name} = ${serviceName}?lower_case.update(id, ${class.name?uncap_first});
        return ${class.name};
    }

    @GetMapping("/delete/{id}")
    public void delete(@PathVariable Long id){
        ${serviceName}?lower_case.delete(id);
    }
}
