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

public class EnumGenerator extends BasicGenerator{
	
	public EnumGenerator(GeneratorOptions generatorOptions) {
		super(generatorOptions);
	}
	
	public void generate() {
	    try {
	        super.generate();
	    } catch (IOException e) {
	        JOptionPane.showMessageDialog(null, e.getMessage());
	    }

	    List<FMEnumeration> enumerations = FMModel.getInstance().getEnumerations();
	    
	    for (FMEnumeration enumeration : enumerations) {
	            Writer out;
	            Map<String, Object> context = new HashMap<String, Object>();
	            try {
	                out = getWriter(enumeration.getName(), enumeration.getTypePackage());
	                if (out != null) {
	                    context.clear();
	                    context.put("enum", enumeration);
	                    context.put("values", enumeration.getValues());
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
