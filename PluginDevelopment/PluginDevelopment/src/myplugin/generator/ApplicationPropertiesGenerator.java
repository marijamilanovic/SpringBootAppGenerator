package myplugin.generator;

import java.io.IOException;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;

import javax.swing.JOptionPane;

import freemarker.template.TemplateException;
import myplugin.generator.fmmodel.FMModel;
import myplugin.generator.options.GeneratorOptions;

public class ApplicationPropertiesGenerator extends BasicGenerator{

    public ApplicationPropertiesGenerator(GeneratorOptions generatorOptions) {
        super(generatorOptions);
    }

    public void generate() {

    	try {
			super.generate();
		} catch (IOException e) {
			JOptionPane.showMessageDialog(null, e.getMessage());
		}
    	
        Writer out;
        Map<String, Object> context = new HashMap<String, Object>();
        try {
            out = getWriter("", "");
            if (out != null) {
                context.clear();
				context.put("port", FMModel.getInstance().getPort());
				context.put("databaseName", FMModel.getInstance().getDatabaseName());
				context.put("databaseUsername", FMModel.getInstance().getDatabaseUsername());
				context.put("databasePassword", String.valueOf(FMModel.getInstance().getDatabasePassword()));
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
