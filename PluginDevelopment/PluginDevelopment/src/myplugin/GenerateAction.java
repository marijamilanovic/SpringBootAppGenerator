package myplugin;

import java.awt.event.ActionEvent;
import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;

import javax.swing.JFileChooser;
import javax.swing.JOptionPane;

import com.certicom.ecc.Repository;
import com.nomagic.magicdraw.actions.MDAction;
import com.nomagic.magicdraw.core.Application;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Package;
import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;

import myplugin.analyzer.AnalyzeException;
import myplugin.analyzer.ModelAnalyzer;
import myplugin.generator.ConfigClassGenerator;
import myplugin.generator.ControllerGenerator;
import myplugin.generator.DtoGenerator;
import myplugin.generator.EJBGenerator;
import myplugin.generator.EnumGenerator;
import myplugin.generator.HomeControllerGenerator;
import myplugin.generator.HomepageGenerator;
import myplugin.generator.MainClassGenerator;
import myplugin.generator.MapperGenerator;
import myplugin.generator.NavBarGenerator;
import myplugin.generator.PomGenerator;
import myplugin.generator.RepositoryGenerator;
import myplugin.generator.ServiceGenerator;
import myplugin.generator.ServiceImplGenerator;
import myplugin.generator.fmmodel.FMModel;
import myplugin.generator.options.GeneratorOptions;
import myplugin.generator.options.ProjectOptions;

/** Action that activate code generation */
@SuppressWarnings("serial")
class GenerateAction extends MDAction{
	
	
	public GenerateAction(String name) {			
		super("", name, null, null);		
	}

	public void actionPerformed(ActionEvent evt) {
		
		if (Application.getInstance().getProject() == null) return;
		Package root = Application.getInstance().getProject().getModel();
		
		if (root == null) return;
	
		ModelAnalyzer analyzer = new ModelAnalyzer(root, "ejb");	
		
		try {
			generateModel(root);
			generateDto(root);
			generateEnum(root);
			generateMainClass(root);
			generateMapper(root);
			generateController(root);
			generateService(root);
			generateServiceImpl(root);
			generateRepository(root);
			generatePom(root);
			generateHomeController(root);
			generateHomepage(root);
			generateNavBar(root);
			generateConfigClass(root);
			
			/**  @ToDo: Also call other generators */ 
			JOptionPane.showMessageDialog(null, "Code is successfully generated! Generated code is in folder: C:/temp ");
			exportToXml();
		} catch (AnalyzeException e) {
			JOptionPane.showMessageDialog(null, e.getMessage());
		} 			
	}
	
	private void generateModel(Package root) throws AnalyzeException {
		ModelAnalyzer analyzer = new ModelAnalyzer(root, "uns.ftn.mbrs.model");
		analyzer.prepareModel();
		GeneratorOptions generatorOptions = ProjectOptions.getProjectOptions().getGeneratorOptions().get("EJBGenerator");
		EJBGenerator ejbGenerator = new EJBGenerator(generatorOptions);
		ejbGenerator.generate();
	}
	
	private void generateDto(Package root) throws AnalyzeException {
		ModelAnalyzer analyzer = new ModelAnalyzer(root, "uns.ftn.mbrs.dto");
		analyzer.prepareModel();
		GeneratorOptions generatorOptions = ProjectOptions.getProjectOptions().getGeneratorOptions().get("DtoGenerator");
		DtoGenerator dtoGenerator = new DtoGenerator(generatorOptions);
		dtoGenerator.generate();
	}
	
	private void generateMapper(Package root) throws AnalyzeException {
		ModelAnalyzer analyzer = new ModelAnalyzer(root, "uns.ftn.mbrs.mappers");
		analyzer.prepareModel();
		GeneratorOptions generatorOptions = ProjectOptions.getProjectOptions().getGeneratorOptions().get("MapperGenerator");
		MapperGenerator mapperGenerator = new MapperGenerator(generatorOptions);
		mapperGenerator.generate();
	}
	
	private void generateEnum(Package root) throws AnalyzeException {
		ModelAnalyzer analyzer = new ModelAnalyzer(root, "uns.ftn.mbrs.model");
		analyzer.prepareModel();
		GeneratorOptions generatorOptions = ProjectOptions.getProjectOptions().getGeneratorOptions().get("EnumGenerator");
		EnumGenerator enumGenerator = new EnumGenerator(generatorOptions);
		enumGenerator.generate();
	}
	
	private void generateMainClass(Package root) throws AnalyzeException {
		ModelAnalyzer analyzer = new ModelAnalyzer(root, "uns.ftn.mbrs");
		analyzer.prepareModel();
		GeneratorOptions generatorOptions = ProjectOptions.getProjectOptions().getGeneratorOptions().get("MainClassGenerator");
		MainClassGenerator mainClassGenerator = new MainClassGenerator(generatorOptions);
		mainClassGenerator.generate();
	}

	private void generateController(Package root) throws AnalyzeException {
		ModelAnalyzer analyzer = new ModelAnalyzer(root, "uns.ftn.mbrs.controller");
		analyzer.prepareModel();
		GeneratorOptions generatorOptions = ProjectOptions.getProjectOptions().getGeneratorOptions().get("ControllerGenerator");
		ControllerGenerator controllerGenerator = new ControllerGenerator(generatorOptions);
		controllerGenerator.generate();
	}
	
	private void generateService(Package root) throws AnalyzeException {
		ModelAnalyzer analyzer = new ModelAnalyzer(root, "uns.ftn.mbrs.service");
		analyzer.prepareModel();
		GeneratorOptions generatorOptions = ProjectOptions.getProjectOptions().getGeneratorOptions().get("ServiceGenerator");
		ServiceGenerator serviceGenerator = new ServiceGenerator(generatorOptions);
		serviceGenerator.generate();

	}

	private void generateServiceImpl(Package root) throws AnalyzeException {
		ModelAnalyzer analyzer = new ModelAnalyzer(root, "uns.ftn.mbrs.service.impl");
		analyzer.prepareModel();
		GeneratorOptions generatorOptions = ProjectOptions.getProjectOptions().getGeneratorOptions().get("ServiceImplGenerator");
		ServiceImplGenerator serviceGenerator = new ServiceImplGenerator(generatorOptions);
		serviceGenerator.generate();

	}
	
	private void generateRepository(Package root) throws AnalyzeException {
		ModelAnalyzer analyzer = new ModelAnalyzer(root,"uns.ftn.mbrs.repository");
		analyzer.prepareModel();
		GeneratorOptions generatorOptions = ProjectOptions.getProjectOptions().getGeneratorOptions().get("RepositoryGenerator");
		RepositoryGenerator repositoryGenerator = new RepositoryGenerator(generatorOptions);
		repositoryGenerator.generate();
	}
	
	private void generatePom(Package root) throws AnalyzeException {
		ModelAnalyzer analyzer = new ModelAnalyzer(root,"");
		analyzer.prepareModel();
		GeneratorOptions generatorOptions = ProjectOptions.getProjectOptions().getGeneratorOptions().get("PomGenerator");
		PomGenerator pomGenerator = new PomGenerator(generatorOptions);
		pomGenerator.generate();
	}
	
	private void generateHomeController(Package root) throws AnalyzeException {
		ModelAnalyzer analyzer = new ModelAnalyzer(root,"uns.ftn.mbrs.controller");
		analyzer.prepareModel();
		GeneratorOptions generatorOptions = ProjectOptions.getProjectOptions().getGeneratorOptions().get("HomeControllerGenerator");
		HomeControllerGenerator homeControllerGenerator = new HomeControllerGenerator(generatorOptions);
		homeControllerGenerator.generate();
	}
	
	private void generateHomepage(Package root) throws AnalyzeException {
		ModelAnalyzer analyzer = new ModelAnalyzer(root,"");
		analyzer.prepareModel();
		GeneratorOptions generatorOptions = ProjectOptions.getProjectOptions().getGeneratorOptions().get("HomepageGenerator");
		HomepageGenerator homepageGenerator = new HomepageGenerator(generatorOptions);
		homepageGenerator.generate();
	}
	
	private void generateNavBar(Package root) throws AnalyzeException {
		ModelAnalyzer analyzer = new ModelAnalyzer(root,"");
		analyzer.prepareModel();
		GeneratorOptions generatorOptions = ProjectOptions.getProjectOptions().getGeneratorOptions().get("NavBarGenerator");
		NavBarGenerator navBarGenerator = new NavBarGenerator(generatorOptions);
		navBarGenerator.generate();
	}
	
	private void generateConfigClass(Package root) throws AnalyzeException {
		ModelAnalyzer analyzer = new ModelAnalyzer(root, "uns.ftn.mbrs");
		analyzer.prepareModel();
		GeneratorOptions generatorOptions = ProjectOptions.getProjectOptions().getGeneratorOptions().get("ConfigClassGenerator");
		ConfigClassGenerator configClassGenerator = new ConfigClassGenerator(generatorOptions);
		configClassGenerator.generate();
	}
	
	private void generateApplicationProperties(Package root) throws AnalyzeException {
		ModelAnalyzer analyzer = new ModelAnalyzer(root, "uns.ftn.mbrs");
		analyzer.prepareModel();
		GeneratorOptions generatorOptions = ProjectOptions.getProjectOptions().getGeneratorOptions().get("ApplicationPropertiesGenerator");
		ConfigClassGenerator configClassGenerator = new ConfigClassGenerator(generatorOptions);
		configClassGenerator.generate();
	}


	private void exportToXml() {
		if (JOptionPane.showConfirmDialog(null, "Do you want to save FM Model?") == 
			JOptionPane.OK_OPTION)
		{	
			JFileChooser jfc = new JFileChooser();
			if (jfc.showSaveDialog(null) == JFileChooser.APPROVE_OPTION) {
				String fileName = jfc.getSelectedFile().getAbsolutePath();
			
				XStream xstream = new XStream(new DomDriver());
				BufferedWriter out;		
				try {
					out = new BufferedWriter(new OutputStreamWriter(
							new FileOutputStream(fileName), "UTF8"));					
					xstream.toXML(FMModel.getInstance().getClasses(), out);
					xstream.toXML(FMModel.getInstance().getEnumerations(), out);
					
				} catch (UnsupportedEncodingException e) {
					JOptionPane.showMessageDialog(null, e.getMessage());				
				} catch (FileNotFoundException e) {
					JOptionPane.showMessageDialog(null, e.getMessage());				
				}		             
			}
		}	
	}	  

}