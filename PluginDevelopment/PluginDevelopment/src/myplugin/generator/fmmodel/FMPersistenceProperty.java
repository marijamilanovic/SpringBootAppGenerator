package myplugin.generator.fmmodel;

public class FMPersistenceProperty extends FMProperty{

	private String columnName;
	private Integer length;
	private Integer precision;
	private Strategy strategy;
	
	public FMPersistenceProperty(String name, String type, String visibility, int lower, int upper, Boolean isUnique,
			Boolean isNullable) {
		super(name, type, visibility, lower, upper, isUnique, isNullable);
		// TODO Auto-generated constructor stub
	}

	public FMPersistenceProperty(FMProperty fmPersistenceProperty, String columnName,Integer length, Integer precision,Strategy strategy) {
		super(fmPersistenceProperty.getName(), fmPersistenceProperty.getType(), fmPersistenceProperty.getVisibility(), fmPersistenceProperty.getLower(), fmPersistenceProperty.getUpper(), fmPersistenceProperty.getIsNullable(), fmPersistenceProperty.getIsUnique());
		this.columnName = columnName;
		this.length = length;
		this.precision = precision;
		this.strategy = strategy;
	}
	

	public String getColumnName() {
		return columnName;
	}

	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}

	public Integer getLength() {
		return length;
	}

	public void setLength(Integer length) {
		this.length = length;
	}

	public Integer getPrecision() {
		return precision;
	}

	public void setPrecision(Integer precision) {
		this.precision = precision;
	}

	public Strategy getStrategy() {
		return strategy;
	}

	public void setStrategy(Strategy strategy) {
		this.strategy = strategy;
	}
	 
}
