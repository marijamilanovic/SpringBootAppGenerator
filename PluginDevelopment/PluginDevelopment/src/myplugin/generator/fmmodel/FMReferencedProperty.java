package myplugin.generator.fmmodel;

public class FMReferencedProperty extends FMProperty {
	private FetchType fetchType;
	private CascadeType cascade;
	private String columnName;
	private String joinTable;
	private String joinColumn;
	private String mappedBy;
	private Integer oppositeEnd;

	public FMReferencedProperty(String name, String type, String visibility, int lower, int upper, Boolean isUnique,
			Boolean isNullable, FetchType fetchType, CascadeType cascade, String columnName, String joinTable,
			String joinColumn,String mappedBy, Integer oppositeEnd) {
		super(name, type, visibility, lower, upper, isUnique, isNullable);
		this.fetchType = fetchType;
		this.cascade = cascade;
		this.columnName = columnName;
		this.joinTable = joinTable;
		this.joinColumn = joinColumn;
		this.mappedBy = mappedBy;
		this.oppositeEnd = oppositeEnd;
	}
	
	public String getJoinColumn() {
		return joinColumn;
	}

	public void setJoinColumn(String joinColumn) {
		this.joinColumn = joinColumn;
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

	public Integer getOppositeEnd() {
		return oppositeEnd;
	}

	public void setOppositeEnd(Integer oppositeEnd) {
		this.oppositeEnd = oppositeEnd;
	}

	public String getMappedBy() {
		return mappedBy;
	}

	public void setMappedBy(String mappedBy) {
		this.mappedBy = mappedBy;
	}
}
