package myplugin.generator;

import java.io.IOException;
import java.io.Writer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.swing.JOptionPane;

import freemarker.template.TemplateException;
import myplugin.generator.fmmodel.FMClass;
import myplugin.generator.fmmodel.FMEnumeration;
import myplugin.generator.fmmodel.FMModel;
import myplugin.generator.fmmodel.FMPersistenceProperty;
import myplugin.generator.fmmodel.FMProperty;
import myplugin.generator.options.GeneratorOptions;

public class FormGenerator extends BasicGenerator {
	
	public FormGenerator(GeneratorOptions generatorOptions) {
		super(generatorOptions);
	}
	
	public void generate() {

		try {
			super.generate();
		} catch (IOException e) {
			JOptionPane.showMessageDialog(null, e.getMessage());
		}

		List<FMClass> classes = FMModel.getInstance().getClasses();
		
		List<FMEnumeration> enumerations = FMModel.getInstance().getEnumerations();
		
		for (int i = 0; i < classes.size(); i++) {
			FMClass cl = classes.get(i);
			Writer out;
			Map<String, Object> context = new HashMap<String, Object>();
			
			try {
				out = getWriter(cl.getName(), cl.getTypePackage());
				if (out != null) {
					context.clear();
					context.put("class", cl);
					context.put("importedPackages", cl.getImportedPackages());
					context.put("referencedProperties", cl.getReferencedProperties());
					List<FMProperty> persistentProperties = new ArrayList<FMProperty>();
					List<FMProperty> properties = new ArrayList<FMProperty>();
					
					for (FMProperty fmProperty : cl.getProperties()) {
						for (FMEnumeration enumeration: enumerations) {
							if (fmProperty.getType().equals(enumeration.getName())) {
								fmProperty.setIsEnum(true);
							}
						}
						
						if (fmProperty instanceof FMPersistenceProperty) {
							persistentProperties.add(fmProperty);
						}else {
							properties.add(fmProperty);
						}
					}
					
					context.put("persistentProperties", persistentProperties);
					context.put("properties", properties);
					
					ArrayList<String> imports = new ArrayList<>();
					String import_str = "";
					
					for(FMProperty p : cl.getReferencedProperties()){
						import_str =  cl.getTypePackage() +"." + p.getType();
						
						if(!imports.contains(import_str) && import_str != ""){
							imports.add(import_str);
						}
					}
					
					context.put("imports", imports);
					getTemplate().process(context, out);
					out.flush();
				}
			} catch (TemplateException e) {
				JOptionPane.showMessageDialog(null, e.getMessage());
			} catch (IOException e) {
				JOptionPane.showMessageDialog(null, e.getMessage());
			}
		}
	}

}
