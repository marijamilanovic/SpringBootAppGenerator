package ${class.typePackage};

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import javax.persistence.EntityNotFoundException;

import uns.ftn.mbrs.model.*;
import uns.ftn.mbrs.service.*;
import uns.ftn.mbrs.repository.*;


@Service
public class ${class.name}ServiceImpl implements ${class.name}Service {

	@Autowired
	private ${class.name}Repository ${class.name?uncap_first}Repository;
	
	
	@Override
	public ${class.name} save(${class.name} ${class.name?uncap_first}) {
		return ${class.name?uncap_first}Repository.save(${class.name?uncap_first});
	}
	
	@Override
	public List<${class.name}> getAll() {
		return ${class.name?uncap_first}Repository.findAll();
	}
	
	@Override
	public ${class.name} getById(Long id) {
		return ${class.name?uncap_first}Repository.findById(id);
	}
	
	@Override
	public void delete(Long id) {
		Optional ${class.name} ${class.name?uncap_first} = ${class.name?uncap_first}Repository.findById(id);
		if(${class.name?uncap_first}.isPresent()){
			${class.name?uncap_first}Repository.delete(${class.name?uncap_first}.get());
		}
		throw new EntityNotFoundException("${class.name} not found with id: " + id);
	}
	
}