package myplugin;

import java.io.File;

import javax.swing.JOptionPane;

import myplugin.generator.options.GeneratorOptions;
import myplugin.generator.options.ProjectOptions;


import com.nomagic.actions.NMAction;
import com.nomagic.magicdraw.actions.ActionsConfiguratorsManager;

/** MagicDraw plugin that performes code generation */
public class MyPlugin extends com.nomagic.magicdraw.plugins.Plugin {
	
	String pluginDir = null; 
	
	public void init() {
		JOptionPane.showMessageDialog( null, "My Plugin init");
		
		pluginDir = getDescriptor().getPluginDirectory().getPath();
		
		// Creating submenu in the MagicDraw main menu 	
		ActionsConfiguratorsManager manager = ActionsConfiguratorsManager.getInstance();		
		manager.addMainMenuConfigurator(new MainMenuConfigurator(getSubmenuActions()));
		
		/** @Todo: load project options (@see myplugin.generator.options.ProjectOptions) from 
		 * ProjectOptions.xml and take ejb generator options */
		
		//for test purpose only:
		GeneratorOptions ejbOptions = new GeneratorOptions("c:/temp/mbrs/src/main/java", "ejbclass", "templates", "{0}.java", true, "ejb"); 				
		ProjectOptions.getProjectOptions().getGeneratorOptions().put("EJBGenerator", ejbOptions);
		System.out.println("EJB DIR " + ejbOptions.getTemplateDir());
		ejbOptions.setTemplateDir(pluginDir + File.separator + ejbOptions.getTemplateDir()); //apsolutna putanja
		
		//Dto
		GeneratorOptions dtoOptions = new GeneratorOptions("c:/temp/mbrs/src/main/java", "dto", "templates", "{0}Dto.java", true, "uns.ftn.mbrs.dto");
		ProjectOptions.getProjectOptions().getGeneratorOptions().put("DtoGenerator", dtoOptions);
		dtoOptions.setTemplateDir(pluginDir + File.separator + dtoOptions.getTemplateDir());
		
		//Enum
		GeneratorOptions enumOptions = new GeneratorOptions("c:/temp/mbrs/src/main/java", "enum", "templates", "{0}.java", true, "uns.ftn.mbrs.model");
		ProjectOptions.getProjectOptions().getGeneratorOptions().put("EnumGenerator", enumOptions);
		System.out.println("ENUM DIR " + enumOptions.getTemplateDir());
		enumOptions.setTemplateDir(pluginDir + File.separator + enumOptions.getTemplateDir());
		
		//Mapper
		GeneratorOptions mapperOptions = new GeneratorOptions("c:/temp/mbrs/src/main/java", "mapper", "templates", "{0}Mapper.java", true, "uns.ftn.mbrs.mappers");
		ProjectOptions.getProjectOptions().getGeneratorOptions().put("MapperGenerator", mapperOptions);
		mapperOptions.setTemplateDir(pluginDir + File.separator + mapperOptions.getTemplateDir());
				
		//Controller
		GeneratorOptions controllerOptions = new GeneratorOptions("c:/temp/mbrs/src/main/java", "controller", "templates", "{0}Controller.java", true, "uns.ftn.mbrs.controller");
		ProjectOptions.getProjectOptions().getGeneratorOptions().put("ControllerGenerator", controllerOptions);
		System.out.println("CONTROLLER DIR " + controllerOptions.getTemplateDir());
		controllerOptions.setTemplateDir(pluginDir + File.separator + controllerOptions.getTemplateDir());
		
		//Service
		GeneratorOptions serviceOptions = new GeneratorOptions("c:/temp/mbrs/src/main/java", "service", "templates", "{0}Service.java", true, "uns.ftn.mbrs.service");
		ProjectOptions.getProjectOptions().getGeneratorOptions().put("ServiceGenerator", serviceOptions);
		serviceOptions.setTemplateDir(pluginDir + File.separator + serviceOptions.getTemplateDir());

		GeneratorOptions serviceImplOptions = new GeneratorOptions("c:/temp/mbrs/src/main/java", "serviceImpl", "templates", "{0}ServiceImpl.java", true, "uns.ftn.mbrs.service.impl");
		ProjectOptions.getProjectOptions().getGeneratorOptions().put("ServiceImplGenerator", serviceImplOptions);
		serviceImplOptions.setTemplateDir(pluginDir + File.separator + serviceImplOptions.getTemplateDir());
		
		//Repository
		GeneratorOptions repositoryOptions = new GeneratorOptions("c:/temp/mbrs/src/main/java", "repository", "templates", "{0}Repository.java", true, "uns.ftn.mbrs.repository");
		ProjectOptions.getProjectOptions().getGeneratorOptions().put("RepositoryGenerator", repositoryOptions);
		repositoryOptions.setTemplateDir(pluginDir + File.separator + repositoryOptions.getTemplateDir());
		
		//Pom
		GeneratorOptions pomOptions = new GeneratorOptions("c:/temp/mbrs", "pom", "templates", "pom.xml", true, "");
		ProjectOptions.getProjectOptions().getGeneratorOptions().put("PomGenerator", pomOptions);
		pomOptions.setTemplateDir(pluginDir + File.separator + pomOptions.getTemplateDir());

	}

	private NMAction[] getSubmenuActions()
	{
	   return new NMAction[]{
			new GenerateAction("Generate"),
	   };
	}
	
	public boolean close() {
		return true;
	}
	
	public boolean isSupported() {				
		return true;
	}
}


