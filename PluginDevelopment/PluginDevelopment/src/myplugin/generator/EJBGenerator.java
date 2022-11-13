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
import myplugin.generator.fmmodel.FMModel;
import myplugin.generator.fmmodel.FMPersistenceProperty;
import myplugin.generator.fmmodel.FMProperty;
import myplugin.generator.fmmodel.FMReferencedProperty;
import myplugin.generator.options.GeneratorOptions;

/**
 * EJB generator that now generates incomplete ejb classes based on MagicDraw
 * class model
 * 
 * @ToDo: enhance resources/templates/ejbclass.ftl template and intermediate
 *        data structure (@see myplugin.generator.fmmodel) in order to generate
 *        complete ejb classes
 */

public class EJBGenerator extends BasicGenerator {

	public EJBGenerator(GeneratorOptions generatorOptions) {
		super(generatorOptions);
	}

	public void generate() {

		try {
			super.generate();
		} catch (IOException e) {
			JOptionPane.showMessageDialog(null, e.getMessage());
		}

		List<FMClass> classes = FMModel.getInstance().getClasses();
		for (int i = 0; i < classes.size(); i++) {
			FMClass cl = classes.get(i);
			Writer out;
			Map<String, Object> context = new HashMap<String, Object>();
			try {
				out = getWriter(cl.getName(), cl.getTypePackage());
				if (out != null) {
					context.clear();
					context.put("class", cl);
					//context.put("properties", cl.getProperties());
					context.put("importedPackages", cl.getImportedPackages());
					context.put("referencedProperties", cl.getReferencedProperties());
					List<FMProperty> persistentProperties = new ArrayList<FMProperty>();
					List<FMProperty> properties = new ArrayList<FMProperty>();
					System.out.println("Properties:" + cl.getProperties().size());
					for (FMProperty fmProperty : cl.getProperties()) {
						if (fmProperty instanceof FMPersistenceProperty) {
							persistentProperties.add(fmProperty);
						}else {
							properties.add(fmProperty);
						}
					}
					context.put("persistentProperties", persistentProperties);
					System.out.println("PROPERTIES");
					for (FMProperty fmProperty : properties) {
						System.out.println(fmProperty.getName());
					}
					context.put("properties", properties);
					System.out.println("********REFERENCED************");
					System.out.println(cl.getReferencedProperties().size());
					for (FMReferencedProperty fmProperty : cl.getReferencedProperties()) {
						System.out.println(fmProperty);
						System.out.println(fmProperty.getType().getClass().getName());
						System.out.println(fmProperty.getName());
						System.out.println(fmProperty.getType());
					}
					System.out.println("********************");
					
					System.out.println("********PERSISTENT************");
					for (FMProperty fmProperty : persistentProperties) {
						System.out.println(fmProperty.getName());
						System.out.println(fmProperty.getType());
					}
					System.out.println("********************");
					
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
