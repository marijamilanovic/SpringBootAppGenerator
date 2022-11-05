package myplugin.generator.fmmodel;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;


public class FMClass extends FMType {	
	
	private String visibility;
	private String tableName;
	//Class properties
	private List<FMProperty> FMProperties = new ArrayList<FMProperty>();
	//list of packages (for import declarations) 
	private List<String> importedPackages = new ArrayList<String>();
	private List<FMReferencedProperty> referencedProperties = new ArrayList<>();
	
	/** @ToDo: add list of methods */
	
	
	public FMClass(String name, String classPackage, String visibility) {
		super(name, classPackage);		
		this.visibility = visibility;
	}	
	
	public FMClass(String name, String typePackage, String visibility, List<FMProperty> fMProperties,
			List<String> importedPackages, List<FMReferencedProperty> referencedProperties) {
		super(name, typePackage);
		this.visibility = visibility;
		FMProperties = fMProperties;
		this.importedPackages = importedPackages;
		this.referencedProperties = referencedProperties;
	}
	
	public List<FMProperty> getProperties(){
		return FMProperties;
	}
	
	public Iterator<FMProperty> getPropertyIterator(){
		return FMProperties.iterator();
	}
	
	public void addProperty(FMProperty property){
		FMProperties.add(property);		
	}
	
	public int getPropertyCount(){
		return FMProperties.size();
	}
	
	public List<String> getImportedPackages(){
		return importedPackages;
	}

	public Iterator<String> getImportedIterator(){
		return importedPackages.iterator();
	}
	
	public void addImportedPackage(String importedPackage){
		importedPackages.add(importedPackage);		
	}
	
	public int getImportedCount(){
		return FMProperties.size();
	}
	
	public String getVisibility() {
		return visibility;
	}

	public void setVisibility(String visibility) {
		this.visibility = visibility;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public List<FMProperty> getFMProperties() {
		return FMProperties;
	}

	public void setFMProperties(List<FMProperty> fMProperties) {
		FMProperties = fMProperties;
	}

	public List<FMReferencedProperty> getReferencedProperties() {
		return referencedProperties;
	}

	public void setReferencedProperties(List<FMReferencedProperty> referencedProperties) {
		this.referencedProperties = referencedProperties;
	}

	public void setImportedPackages(List<String> importedPackages) {
		this.importedPackages = importedPackages;
	}

	public void addReferencedProperty(FMReferencedProperty referencedProperty) {
		// TODO Auto-generated method stub
		referencedProperties.add(referencedProperty);
	}
	
	
}
