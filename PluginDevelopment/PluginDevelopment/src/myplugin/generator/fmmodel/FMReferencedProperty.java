package myplugin.generator.fmmodel;

public class FMReferencedProperty extends FMProperty {
	private FetchType fetchType;
	private CascadeType cascade;
	private String columnName;
	private String joinTable;
	private Integer oppositeEnd;

	public FMReferencedProperty(String name, String type, String visibility, int lower, int upper, Boolean isUnique,
			Boolean isNullable, FetchType fetchType, CascadeType cascade, String columnName, String joinTable,
			Integer oppositeEnd) {
		super(name, type, visibility, lower, upper, isUnique, isNullable);
		this.fetchType = fetchType;
		this.cascade = cascade;
		this.columnName = columnName;
		this.joinTable = joinTable;
		this.oppositeEnd = oppositeEnd;
	}

	public FetchType getFetchType() {
		return fetchType;
	}
	
	public void setFetchType(FetchType fetchType) {
		this.fetchType = fetchType;
	}
	
	public CascadeType getCascade() {
		return cascade;
	}
	
	public void setCascade(CascadeType cascade) {
		this.cascade = cascade;
	}
	
	public String getColumnName() {
		return columnName;
	}
	
	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}
	
	public String getJoinTable() {
		return joinTable;
	}
	
	public void setJoinTable(String joinTable) {
		this.joinTable = joinTable;
	}
	
}
