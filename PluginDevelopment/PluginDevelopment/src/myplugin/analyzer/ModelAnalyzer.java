package myplugin.analyzer;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import myplugin.generator.fmmodel.CascadeType;
import myplugin.generator.fmmodel.FMClass;
import myplugin.generator.fmmodel.FMEnumeration;
import myplugin.generator.fmmodel.FMModel;
import myplugin.generator.fmmodel.FMPersistenceProperty;
import myplugin.generator.fmmodel.FMProperty;
import myplugin.generator.fmmodel.FMReferencedProperty;
import myplugin.generator.fmmodel.FetchType;
import myplugin.generator.fmmodel.Strategy;

import com.nomagic.uml2.ext.jmi.helpers.ModelHelper;
import com.nomagic.uml2.ext.jmi.helpers.StereotypesHelper;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Element;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.EnumerationLiteral;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Package;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Class;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Enumeration;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Property;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Type;
import com.nomagic.uml2.ext.magicdraw.mdprofiles.Stereotype;


/** Model Analyzer takes necessary metadata from the MagicDraw model and puts it in 
 * the intermediate data structure (@see myplugin.generator.fmmodel.FMModel) optimized
 * for code generation using freemarker. Model Analyzer now takes metadata only for ejb code 
 * generation

 * @ToDo: Enhance (or completely rewrite) myplugin.generator.fmmodel classes and  
 * Model Analyzer methods in order to support GUI generation. */ 


public class ModelAnalyzer {	
	//root model package
	private Package root;  // to je onaj Data paket iz magicdraw-a
	
	//java root package for generated code
	private String filePackage;
	
	public ModelAnalyzer(Package root, String filePackage) {
		super();
		this.root = root;
		this.filePackage = filePackage;
	}

	public Package getRoot() {
		return root;
	}
	
	public void prepareModel() throws AnalyzeException {
		FMModel.getInstance().getClasses().clear();
		FMModel.getInstance().getEnumerations().clear();
		processPackage(root, filePackage);
	}
	
	private void processPackage(Package pack, String packageOwner) throws AnalyzeException {
		//Recursive procedure that extracts data from package elements and stores it in the 
		// intermediate data structure
		
		if (pack.getName() == null) throw  
			new AnalyzeException("Packages must have names!");
		
		String packageName = packageOwner;
		
		if (pack != root) {
			packageName += "." + pack.getName();
		}
		
		if (pack.hasOwnedElement()) {
			
			for (Iterator<Element> it = pack.getOwnedElement().iterator(); it.hasNext();) {
				Element ownedElement = it.next();
				
				if (ownedElement instanceof Class) {
					Class cl = (Class)ownedElement;
					FMClass fmClass = getClassData(cl, packageName);
					FMModel.getInstance().getClasses().add(fmClass);
				}
				
				if (ownedElement instanceof Enumeration) {
					Enumeration en = (Enumeration)ownedElement;
					FMEnumeration fmEnumeration = getEnumerationData(en, packageName);
					FMModel.getInstance().getEnumerations().add(fmEnumeration);
				}								
			}
			
			for (Iterator<Element> it = pack.getOwnedElement().iterator(); it.hasNext();) {
				Element ownedElement = it.next();
				
				if (ownedElement instanceof Package) {					
					Package ownedPackage = (Package)ownedElement;
					
					if (StereotypesHelper.getAppliedStereotypeByString(ownedPackage, "BusinessApp") != null)
						//only packages with stereotype BusinessApp are candidates for metadata extraction and code generation:
						processPackage(ownedPackage, packageName);
				}
			}
			
			/** @ToDo:
			  * Process other package elements, as needed */ 
		}
	}
	
	private FMClass getClassData(Class cl, String packageName) throws AnalyzeException {
		if (cl.getName() == null) 
			throw new AnalyzeException("Classes must have names!");
		
		FMClass fmClass = new FMClass(cl.getName(), packageName, cl.getVisibility().toString());
		Iterator<Property> it = ModelHelper.attributes(cl);
		
		while (it.hasNext()) {
			Property p = it.next();
			//ako ima asocijaciju ka nekoj klasi => ima ReferencedProperty
			if (p.getOpposite() != null) {
				FMReferencedProperty referencedProperty = getReferencedPropertyData(p, cl);
				fmClass.addReferencedProperty(referencedProperty);
			} else {
				FMProperty prop = getPropertyData(p, cl);
				fmClass.addProperty(prop);
			}	
		}	
		
		/** @ToDo:
		 * Add import declarations etc. */		
		Stereotype entity = StereotypesHelper.getAppliedStereotypeByString(cl, "Entity");
		
		if (entity != null) {
			List<String> tagValues = StereotypesHelper.getStereotypePropertyValue(cl, entity, "tableName");
			
			if (tagValues != null && tagValues.size()!= 0) {
				fmClass.setTableName(tagValues.get(0));
			}
		}
		
		return fmClass;
	}

	private FMProperty getPropertyData(Property p, Class cl) throws AnalyzeException {
		String attName = p.getName();
		
		if (attName == null) 
			throw new AnalyzeException("Properties of the class: " + cl.getName() +
					" must have names!");
		
		Type attType = p.getType();
		
		if (attType == null)
			throw new AnalyzeException("Property " + cl.getName() + "." +
			p.getName() + " must have type!");
		
		String typeName = attType.getName();
		
		if (typeName == null)
			throw new AnalyzeException("Type ot the property " + cl.getName() + "." +
			p.getName() + " must have name!");		
			
		int lower = p.getLower();
		int upper = p.getUpper();
		Boolean isUnique = p.isUnique();
		Boolean isNullable = true;
		
		if (lower == 1) {
			// 1 -> nullable = false (obavezno da se unese)
			isNullable = false;
		}
		
		
		FMProperty prop = new FMProperty(attName, typeName,  p.getVisibility().toString(), 
				lower, upper, isUnique, isNullable); 
		
		Stereotype persistentProperty = StereotypesHelper.getAppliedStereotypeByString(p, "PersistenceProperty");
		
		if (persistentProperty != null) {
			prop = createPersistentProperty(prop, p, persistentProperty);
		}
	
		return prop;		
	}	
	
	private FMReferencedProperty getReferencedPropertyData(Property p, Class cl) throws AnalyzeException{
		String attName = p.getName();
		
		if (attName == null) 
			throw new AnalyzeException("Properties of the class: " + cl.getName() +
					" must have names!");
		
		Type attType = p.getType();
		
		if (attType == null)
			throw new AnalyzeException("Property " + cl.getName() + "." +
			p.getName() + " must have type!");
		
		String typeName = attType.getName();
		
		if (typeName == null)
			throw new AnalyzeException("Type ot the property " + cl.getName() + "." +
			p.getName() + " must have name!");		
		
        Stereotype referencedPropertyStereotype = null;
        FMReferencedProperty referencedProperty = null;
		int upper = p.getUpper();
		Integer oppositeEnd = p.getOpposite().getUpper();
		FMProperty fmProperty = getPropertyData(p, cl);
		
		if(upper == -1 && oppositeEnd == -1) {
			referencedPropertyStereotype = StereotypesHelper.getAppliedStereotypeByString(p, "ManyToMany");
		} else if(upper == -1 && oppositeEnd == 1) {
			referencedPropertyStereotype = StereotypesHelper.getAppliedStereotypeByString(p, "OneToMany");
		} else if(upper == 1 && oppositeEnd == -1) {
			referencedPropertyStereotype = StereotypesHelper.getAppliedStereotypeByString(p, "ManyToOne");
		} else {
			referencedPropertyStereotype = StereotypesHelper.getAppliedStereotypeByString(p, "OneToOne");
		}

		if(referencedPropertyStereotype != null) {
			referencedProperty = createReferencedProperty(fmProperty, p, referencedPropertyStereotype);
		}
		
		return referencedProperty;
	}
	

	private FMPersistenceProperty createPersistentProperty(FMProperty prop, Property p, Stereotype persistentProperty) {
		// TODO Auto-generated method stub
		String columnName = null;
		Integer length = null;
		Integer precision = null;
		Strategy strategy = null;
		
		List<Property> propertyTags = persistentProperty.getOwnedAttribute();
		
		for (int i=0; i < propertyTags.size(); i++) {
			Property tag = propertyTags.get(i);
			
            List tagValues = StereotypesHelper.getStereotypePropertyValue(p, persistentProperty, tag.getName());
            
            if (tagValues.size() > 0) {
				switch(tag.getName()) {
					case "columnName":
						columnName =  tagValues.get(0).toString();
						break;
					case "length":
						length = (Integer) tagValues.get(0);
						break;
					case "precision":
						precision = (Integer) tagValues.get(0);
						break;
					case "strategy":
						if (tagValues.get(0) instanceof EnumerationLiteral) {
							strategy = Strategy.valueOf(getEnumerationString((EnumerationLiteral)tagValues.get(0)));
						}
						break;
				}
			}
		}
		
		return new FMPersistenceProperty(prop, columnName, length, precision, strategy);
	}
	
	private FMReferencedProperty createReferencedProperty(FMProperty prop, Property p, Stereotype referencedProperty) {
		// TODO Auto-generated method stub
		FetchType fetchType = null;
		CascadeType cascadeType = null;
		String joinTable = null;
		String columnName = null;
		String joinColumn = null;
		int upper = p.getUpper();
		Integer oppositeEnd = p.getOpposite().getUpper();
		
		if (prop.getName().equals("") && prop.getUpper() == -1) {
			prop.setName(prop.getType().toLowerCase().concat("s"));
		}else if (prop.getName().equals("")) {
			prop.setName(Character.toLowerCase(prop.getType().charAt(0)) + prop.getType().substring(1));
		}
		
		// Retrieve tagged values from ReferencedProperty and its derived stereotypes
	    List<Stereotype> allStereotypes = new ArrayList<>();
	    allStereotypes.add(referencedProperty);

	    // Get the base classes that the stereotype extends
	    for (Element baseClass : referencedProperty.getSuperClass()) {
	        if (baseClass instanceof Stereotype) {
	            allStereotypes.add((Stereotype) baseClass);
	        }
	    }
		
	    for (Stereotype stereotype : allStereotypes) {
	        // Retrieve tagged values from the Property element for the current stereotype
	        List<Property> tagProperties = stereotype.getOwnedAttribute();
	        
		    for (Property tag : tagProperties) {
	            List<Object> tagValues = StereotypesHelper.getStereotypePropertyValue(p, stereotype, tag.getName());
	
	            if (!tagValues.isEmpty()) {
	                switch (tag.getName()) {
	                    case "columnName":
	                        columnName = (String) tagValues.get(0);
	                        break;
	                    case "fetchType":
	                        if (tagValues.get(0) instanceof EnumerationLiteral) {
	                            fetchType = FetchType.valueOf(((EnumerationLiteral) tagValues.get(0)).getName());
	                        }
	                        break;
	                    case "cascade":
	                        if (tagValues.get(0) instanceof EnumerationLiteral) {
	                            cascadeType = CascadeType.valueOf(((EnumerationLiteral) tagValues.get(0)).getName());
	                        }
	                        break;
	                    case "joinTable":
	                        joinTable = (String) tagValues.get(0);
	                        break;
	                    case "joinColumn":
	                        joinColumn = (String) tagValues.get(0);
	                        break;
	                }
	            }
		     }
		}
		
		return new FMReferencedProperty(prop.getName(), prop.getType(), prop.getVisibility().toString(),  prop.getLower(), prop.getUpper(),
				prop.getIsUnique(), prop.getIsNullable(), fetchType, cascadeType, columnName, joinTable, joinColumn, oppositeEnd);
	}

	private FMEnumeration getEnumerationData(Enumeration enumeration, String packageName) throws AnalyzeException {
		FMEnumeration fmEnum = new FMEnumeration(enumeration.getName(), packageName);
		List<EnumerationLiteral> list = enumeration.getOwnedLiteral();
		
		for (int i = 0; i < list.size() - 1; i++) {
			EnumerationLiteral literal = list.get(i);
			
			if (literal.getName() == null)  
				throw new AnalyzeException("Items of the enumeration " + enumeration.getName() +
				" must have names!");
			
			fmEnum.addValue(literal.getName());
		}
		return fmEnum;
	}	
	
	private String getEnumerationString(EnumerationLiteral enumerationLiteral) {
		return enumerationLiteral.getName();
	}
}
