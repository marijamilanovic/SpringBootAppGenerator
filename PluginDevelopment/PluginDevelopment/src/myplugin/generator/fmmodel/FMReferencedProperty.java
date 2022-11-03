package myplugin.generator.fmmodel;

public class FMReferencedProperty {
	private FetchType fetchType;
	private CascadeType cascade;
	private String columnName;
	private String joinTable;
	
	public FMReferencedProperty() {
		super();
	}
	
	public FMReferencedProperty(FetchType fetchType, CascadeType cascade, String columnName, String joinTable) {
		super();
		this.fetchType = fetchType;
		this.cascade = cascade;
		this.columnName = columnName;
		this.joinTable = joinTable;
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
