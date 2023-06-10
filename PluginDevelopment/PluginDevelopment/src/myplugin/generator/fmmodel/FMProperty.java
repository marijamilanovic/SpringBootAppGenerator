package myplugin.generator.fmmodel;

import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Type;

public class FMProperty extends FMElement  {
	//Property type
	private String type;
	// Property visibility (public, private, protected, package)
	private String visibility;
	//Multiplicity (lower value)
	private Integer lower;
	//Multiplicity (upper value) 
	private Integer upper;
	
	/** @ToDo: Add length, precision, unique... whatever is needed for ejb class generation
	 * Also, provide these meta-attributes or tags in the modeling languange metaclass or 
	 * stereotype */
	private Boolean isUnique;
	private Boolean isNullable;

	
	public FMProperty(String name, String type, String visibility, int lower, int upper, Boolean isUnique, Boolean isNullable) {
		super(name);
		this.type = type;
		this.visibility = visibility;
		this.lower = lower;
		this.upper = upper;		
		this.isUnique = isUnique;
		this.isNullable = isNullable;
	}
		
	public FMProperty(String name, String type, String visibility, Integer lower, Integer upper) {
		super(name);
		this.type = type;
		this.visibility = visibility;
		this.lower = lower;
		this.upper = upper;
	}

	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getVisibility() {
		return visibility;
	}
	public void setVisibility(String visibility) {
		this.visibility = visibility;
	}
	
	public Integer getLower() {
		return lower;
	}

	public void setLower(Integer lower) {
		this.lower = lower;
	}

	public Integer getUpper() {
		return upper;
	}

	public void setUpper(Integer upper) {
		this.upper = upper;
	}

	public Boolean getIsUnique() {
		return isUnique;
	}

	public void setIsUnique(Boolean isUnique) {
		this.isUnique = isUnique;
	}

	public Boolean getIsNullable() {
		return isNullable;
	}

	public void setIsNullable(Boolean isNullable) {
		this.isNullable = isNullable;
	}
}
