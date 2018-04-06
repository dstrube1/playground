package com.dstrube.dbutil;

import java.util.ArrayList;

/**
 * This class represents an object with a table name and a list of column
 * names and a list of column data types
 * 
 */
public class TableColumnList {
	private String tableName;
	private ArrayList<String> columnDataTypes;
	private ArrayList<String> columnNames;

	public TableColumnList() {
		tableName = "";
		columnDataTypes = new ArrayList<>();
		columnNames = new ArrayList<>();
	}

	public TableColumnList(String tableName, ArrayList<String> columnDataTypes, ArrayList<String> columnNames) {
		this.tableName = tableName;
		this.columnDataTypes = columnDataTypes;
		this.columnNames = columnNames;
	}

	public TableColumnList(String tableName) {
		this.tableName = tableName;
		columnDataTypes = new ArrayList<>();
		columnNames = new ArrayList<>();
	}

	public TableColumnList(ArrayList<String> columnDataTypes, ArrayList<String> columnNames) {
		tableName = "";
		this.columnDataTypes = columnDataTypes;
		this.columnNames = columnNames;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getTableName(){
		return tableName;
	}
	
	public void setColumnDataTypes(ArrayList<String> columnDataTypes) {
		this.columnDataTypes = columnDataTypes;
	}

	public ArrayList<String> getColumnDataTypes(){
		return columnDataTypes;
	}
	
	public void setColumnNames(ArrayList<String> columnNames) {
		this.columnNames = columnNames;
	}

	public ArrayList<String> getColumnNames(){
		return columnNames;
	}
}
