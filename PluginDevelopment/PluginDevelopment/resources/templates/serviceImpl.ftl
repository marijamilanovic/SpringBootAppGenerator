package ${class.typePackage};

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import uns.ftn.mbrs.model.*;
import uns.ftn.mbrs.service.*;
import uns.ftn.mbrs.repository.*;
import uns.ftn.mbrs.mappers.*;
import uns.ftn.mbrs.dto.*;

import javax.persistence.EntityNotFoundException;


@Service
public class ${class.name}ServiceImpl implements ${class.name}Service {

	@Autowired
	private ${class.name}Repository ${class.name?uncap_first}Repository;
	
	@Autowired
	private ${class.name}Mapper ${class.name?uncap_first}Mapper;
	
	
	@Override
	public ${class.name}Dto save(${class.name} ${class.name?uncap_first}) {
		${class.name} saved${class.name} = ${class.name?uncap_first}Repository.save(${class.name?uncap_first});
		return ${class.name?uncap_first}To${class.name}Dto(saved${class.name});
	}

	@Override
	public ${class.name}Dto update(${class.name} ${class.name?uncap_first}) {
		${class.name} saved${class.name} = ${class.name?uncap_first}Repository.save(${class.name?uncap_first});
		return ${class.name?uncap_first}To${class.name}Dto(saved${class.name});
	}
	
	@Override
	public List<${class.name}Dto> getAll() {
		List<${class.name}> ${class.name?uncap_first}s = ${class.name?uncap_first}Repository.findAll();
		return ${class.name?uncap_first}sTo${class.name}Dtos(${class.name?uncap_first}s);
	}
	
	@Override
	public Optional<${class.name}Dto> getById(Long id) {
		${class.name} ${class.name} = ${class.name?uncap_first}Repository.findById(id);
		return ${class.name?uncap_first}To${class.name}Dto(${class.name});
	}
	
	@Override
	public void delete(Long id) {
		Optional<${class.name}> ${class.name?uncap_first} = ${class.name?uncap_first}Repository.findById(id);
		if(${class.name?uncap_first}.isPresent()){
			${class.name?uncap_first}Repository.delete(${class.name?uncap_first}.get());
		}
		throw new EntityNotFoundException("${class.name} not found with id: " + id);
	}
	
}