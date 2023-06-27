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
import myplugin.generator.fmmodel.FMProperty;
import myplugin.generator.options.GeneratorOptions;

public class MapperGenerator extends BasicGenerator {
	
	public MapperGenerator(GeneratorOptions generatorOptions) {
		super(generatorOptions);
	}
	
	public void generate() {
	    try {
	        super.generate();
	    } catch (IOException e) {
	        JOptionPane.showMessageDialog(null, e.getMessage());
	    }

	    List<FMClass> classes = FMModel.getInstance().getClasses();
	    for (FMClass cl : classes) {
	            Writer out;
	            Map<String, Object> context = new HashMap<String, Object>();
	            try {
	                out = getWriter(cl.getName(), cl.getTypePackage());
	                if (out != null) {
	                    context.clear();
	                    context.put("class", cl);
	                    context.put("importedPackages", cl.getImportedPackages());
	                    
	                    ArrayList<String> imports = new ArrayList<>();
	                    String import_str = "";
	                    
	                    for (FMProperty p : cl.getReferencedProperties()) {
	                        import_str = cl.getTypePackage() + "." + p.getType();
	                        if (!imports.contains(import_str) && import_str != "") {
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
