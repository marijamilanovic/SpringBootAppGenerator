package ${class.typePackage};

import java.util.*;
import java.util.List;
import uns.ftn.mbrs.model.*;
import uns.ftn.mbrs.dto.*;


public interface ${class.name}Service {
	${class.name}Dto save(${class.name} ${class.name?uncap_first});
	
	${class.name}Dto update(${class.name} ${class.name?uncap_first});
	
	List<${class.name}Dto> getAll();
	
	Optional<${class.name}Dto> getById(Long id);
	
	void delete(Long id);
}
