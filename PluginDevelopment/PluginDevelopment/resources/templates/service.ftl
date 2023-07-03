package ${class.typePackage};

import java.util.*;
import java.util.List;
import uns.ftn.mbrs.model.*;


public interface ${class.name}Service {
	${class.name} save(${class.name} ${class.name?uncap_first});
	
	${class.name} update(${class.name} ${class.name?uncap_first});
	
	List<${class.name}> getAll();
	
	Optional<${class.name}> getById(Long id);
	
	void delete(Long id);
}
