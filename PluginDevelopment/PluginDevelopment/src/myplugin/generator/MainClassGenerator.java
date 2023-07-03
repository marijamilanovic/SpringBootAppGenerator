package myplugin.generator;

import java.io.IOException;
import java.io.Writer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.swing.JOptionPane;

import com.nomagic.magicdraw.core.Application;

import freemarker.template.TemplateException;
import myplugin.generator.fmmodel.FMClass;
import myplugin.generator.fmmodel.FMModel;
import myplugin.generator.options.GeneratorOptions;

public class MainClassGenerator extends BasicGenerator {
	public final String PACKAGE_NAME = "uns.ftn.mbrs";
	public final String PROJECT_NAME = Application.getInstance().getProject().getName();
	
	public MainClassGenerator(GeneratorOptions generatorOptions) {	
		super(generatorOptions);
	}

	public void generate() {
		try {
			super.generate();
		} catch (IOException e) {
			JOptionPane.showMessageDialog(null, e.getMessage());
		}

		Map<String, Object> context = new HashMap<String, Object>();
		Writer out;
		
		try {
			out = getWriter(PROJECT_NAME, PACKAGE_NAME);
			
			
			if (out != null) {
				context.clear();
				context.put("project_name", PROJECT_NAME);
				context.put("package", PACKAGE_NAME);
				
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