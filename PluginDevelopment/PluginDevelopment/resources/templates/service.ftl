package ${class.typePackage};

import java.util.*;
import org.springframework.stereotype.Service;
import java.util.List;
import uns.ftn.mbrs.model.*;

@Service
public interface ${class.name}Service {
	${class.name} save(${class.name} ${class.name?uncap_first});
	
	List<${class.name}> getAll();
	
	${class.name} getById(Long id);
	
	void delete(Long id);
}
