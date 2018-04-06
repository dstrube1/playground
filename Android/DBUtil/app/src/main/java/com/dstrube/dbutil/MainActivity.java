package com.dstrube.dbutil;

import android.app.Activity;
import android.database.Cursor;
import android.database.sqlite.SQLiteCursorDriver;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteQuery;
import android.os.Bundle;
import android.util.Log;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Hashtable;

public class MainActivity extends Activity {

    private Utils dbUtil;
    private TextView textView;
    private final String TABLE_NAME_first = "first";
    // private final String TABLE_NAME_second = "second";
    // private final String TABLE_NAME_3rd = "3rd";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        final boolean DISPLAY_ON = true;
        final boolean DISPLAY_OFF = false;
        textView = findViewById(R.id.textView);

        // success
        if (!testCreates(DISPLAY_ON)) {
            Toast.makeText(this, "Error on testCreates", Toast.LENGTH_LONG).show();
            return;
        }

        // success
        if (!testTableNames(DISPLAY_ON)) {
            Toast.makeText(this, "Error on testTableNames", Toast.LENGTH_LONG).show();
            return;
        }

        // success
        if (!testColumns(DISPLAY_ON)) {
            Toast.makeText(this, "Error on testColumns", Toast.LENGTH_LONG).show();
            return;
        }

        // SQLiteDatabase db0 = dbUtil.getWritableDatabase();
        // SQLiteDatabase db1 = dbUtil.getReadableDatabase();
        //
        // Map<String,String> tables0 = db0.getSyncedTables();
        // int version0 = db0.getVersion();
        // boolean open0 = db0.isOpen();
        //
        // Map<String,String> tables1 = db1.getSyncedTables();
        // int version1 = db1.getVersion();
        // boolean open1 = db1.isOpen();

        if (!testSelects(DISPLAY_OFF)) {
            // error expected before inserting any rows
            Toast.makeText(this, "Error on testSelects(DISPLAY_OFF)", Toast.LENGTH_LONG).show();
            return;
        }

        if (!testInsert()) {
            Toast.makeText(this, "Error on testInsert", Toast.LENGTH_LONG).show();
            return;
        }

        if (!testSelects(DISPLAY_ON)) {
            // still getting errors?
            Toast.makeText(this, "Error on testSelects(DISPLAY_ON)", Toast.LENGTH_LONG).show();
            return;
        }

        Toast.makeText(this, "No Error!", Toast.LENGTH_LONG).show();
    }

    /**
     * testing all constructors of DBUtil
     */
    //@SuppressLint("NewApi")
    private boolean testCreates(boolean display) {
        boolean result = true;
        try {
            StringBuilder text = new StringBuilder();
            text.append(textView.getText());
            result = result && create0();
            text.append("\n 0: " + dbUtil.getDatabaseName());
            result = result && create1();
            text.append("\n 1: " + dbUtil.getDatabaseName());
            result = result && create2Version();
            text.append("\n 2a: " + dbUtil.getDatabaseName());
            result = result && create2dbName();
            text.append("\n 2b: " + dbUtil.getDatabaseName());
            result = result && create3();
            text.append("\n 3: " + dbUtil.getDatabaseName());
            result = result && create4();
            text.append("\n 4: " + dbUtil.getDatabaseName());
            if (display) {
                textView.setText(text);
            } else {
                textView.setText("");
            }
            // this throws a null :
            // SQLiteDatabase db = dbUtil.getReadableDatabase();
            // textView.setText(textView.getText() + " - " + db.toString());

        } catch (Exception e) {
            textView.setText("Error in testCreates: " + e.getMessage());
            return false;
        }
        return result;
    }

    // success
    /**
     * testing constructor of DBUtil with 0 params
     */
    private boolean create0() {
        try {
            dbUtil = new Utils();
            return true;
        } catch (UtilsException e) {
            textView.setText("Error creating utils object with 0 params: "
                    + e.getMessage());
            return false;
        }
    }

    // success
    /**
     * testing constructor of DBUtil with 1 param
     */
    private boolean create1() {
        try {
            dbUtil = new Utils(getBaseContext());
            return true;
        } catch (UtilsException e) {
            textView.setText("Error creating utils object with 1 params: "
                    + e.getMessage());
            return false;
        }
    }

    // success
    /**
     * testing constructor of DBUtil with 2 params
     */
    private boolean create2Version() {
        try {
            dbUtil = new Utils(getBaseContext(), 2);
            return true;
        } catch (UtilsException e) {
            textView.setText("Error creating utils object with 2 params, version: "
                    + e.getMessage());
            return false;
        }
    }

    // success
    /**
     * testing constructor of DBUtil with 2 params
     */
    private boolean create2dbName() {
        try {
            dbUtil = new Utils(getBaseContext(), "anotherVaildName");
            return true;
        } catch (UtilsException e) {
            textView.setText("Error creating utils object with 2 params, dbName: "
                    + e.getMessage());
            return false;
        }
    }

    // success
    /**
     * testing constructor of DBUtil with 3 params
     */
    private boolean create3() {
        try {
            dbUtil = new Utils(getBaseContext(), "androidsqliteFromCreate3.db",
                    2);
            return true;
        } catch (UtilsException e) {
            textView.setText("Error creating utils object with 2 params, dbName: "
                    + e.getMessage());
            return false;
        }
    }

    // success
    /**
     * testing constructor of DBUtil with 4 params
     */
    private boolean create4() {
        try {
            SQLiteDatabase.CursorFactory cursorFactory = new SQLiteDatabase.CursorFactory() {

                @Override
                public Cursor newCursor(SQLiteDatabase db,
                                        SQLiteCursorDriver masterQuery, String editTable,
                                        SQLiteQuery query) {
                    return null;
                }
            };
            dbUtil = new Utils(getBaseContext(), "androidsqliteFromCreate4.db",
                    cursorFactory, 2);
            return true;
        } catch (UtilsException e) {
            textView.setText("Error creating utils object with 2 params, dbName: "
                    + e.getMessage());
            return false;
        }
    }

    // success
    /**
     * testing the getter and setter of table names
     */
    private boolean testTableNames(boolean display) {
        try {
            ArrayList<String> tableNames = dbUtil.getTableNames();
            if (tableNames == null) {
                if (display) {
                    textView.setText(textView.getText()
                            + "\n tableNames is null; makes sense; setting tableNames...");
                }
            } else if (tableNames.size() == 0) {
                textView.setText(textView.getText()
                        + "\n tableNames is empty; makes sense");
            } else {
                textView.setText(textView.getText()
                        + "\n tableNames is not empty. Wha?!");
                return false;
            }

            ArrayList<String> tableNamesIn = new ArrayList<>();
            tableNamesIn.add(TABLE_NAME_first);
            dbUtil.setTableNames(tableNamesIn);
            tableNames = dbUtil.getTableNames();
            if (tableNames == null) {
                textView.setText(textView.getText()
                        + "\n tableNames is null. Wha?!");
                return false;
            } else if (tableNames.size() == 0) {
                textView.setText(textView.getText()
                        + "\n tableNames is empty. Wha?!");
                return false;
            } else {
                if (display) {
                    textView.setText(textView.getText()
                            + "\n tableNames is not empty; makes sense");
                }
            }

            // let's go ahead and add the rest in preparation
            // tableNamesIn.add(TABLE_NAME_second);
            // tableNamesIn.add(TABLE_NAME_3rd);
            dbUtil.setTableNames(tableNamesIn);
            tableNames = dbUtil.getTableNames();
            textView.setText(textView.getText() + "\n we have "
                    + tableNames.size() + " tables");
            return true;
        } catch (Exception e) {
            textView.setText("Error in testTableNames: " + e.getMessage());
            return false;
        }
    }

    // success
    /**
     * testing the getters and setter of column names and data types
     *
     * @return
     */
    private boolean testColumns(boolean display) {
        try {
            ArrayList<TableColumnList> columns = dbUtil.getColumns();

            if (columns == null) {
                if (display) {
                    textView.setText(textView.getText()
                            + "\n columns is null; makes sense; setting columns...");
                }
            } else if (columns.size() == 0) {
                textView.setText(textView.getText()
                        + "\n columns is empty; makes sense");
            } else {
                textView.setText(textView.getText()
                        + "\n columns is not empty. Wha?!");
                return false;
            }

            ArrayList<TableColumnList> columnsIn = new ArrayList<>();

            TableColumnList tableColumnList = new TableColumnList();

            ArrayList<String> columnDataTypes = new ArrayList<>();
            ArrayList<String> columnNames = new ArrayList<>();

            columnDataTypes.add("INTEGER PRIMARY KEY");
            columnDataTypes.add("TEXT");

            columnNames.add("firstId");
            columnNames.add("firstName");

            tableColumnList.setColumnDataTypes(columnDataTypes);
            tableColumnList.setColumnNames(columnNames);
            tableColumnList.setTableName(TABLE_NAME_first);

            columnsIn.add(tableColumnList);
            dbUtil.setColumns(columnsIn);
            columns = dbUtil.getColumns();
            if (columns == null) {
                textView.setText(textView.getText()
                        + "\n columns is null. Wha?!");
                return false;
            } else if (columns.size() == 0) {
                textView.setText(textView.getText()
                        + "\n columns is empty. Wha?!");
                return false;
            } else {
                if (display) {
                    textView.setText(textView.getText()
                            + "\n columns is not empty; makes sense");
                }
            }

            // let's go ahead and add the rest in preparation
            // tableColumnList = new TableColumnList();
            // columnDataTypes = new ArrayList<>();
            // columnNames = new ArrayList<>();
            //
            // columnDataTypes.add("INTEGER PRIMARY KEY");
            // columnDataTypes.add("TEXT");
            // columnDataTypes.add("TEXT");
            // columnDataTypes.add("INTEGER");
            //
            // columnNames.add("secondId");
            // columnNames.add("secondName");
            // columnNames.add("secondText");
            // columnNames.add("firstId");
            //
            // tableColumnList.setColumnDataTypes(columnDataTypes);
            // tableColumnList.setColumnNames(columnNames);
            // tableColumnList.setTableName(TABLE_NAME_second);
            //
            // columnsIn.add(tableColumnList);
            //
            // tableColumnList = new TableColumnList();
            // columnDataTypes = new ArrayList<>();
            // columnNames = new ArrayList<>();
            //
            // columnDataTypes.add("INTEGER PRIMARY KEY");
            // columnDataTypes.add("TEXT");
            //
            // columnNames.add("3rdId");
            // columnNames.add("3rdName");
            //
            // tableColumnList.setColumnDataTypes(columnDataTypes);
            // tableColumnList.setColumnNames(columnNames);
            // tableColumnList.setTableName(TABLE_NAME_3rd);
            //
            // columnsIn.add(tableColumnList);
            //
            // dbUtil.setColumns(columnsIn);
            // columns = dbUtil.getColumns();

            /*
             * if (columns == null) { textView.setText(textView.getText() +
             * "\n columns is null. Wha?!"); return false; } else
             */if (columns.size() == 0) {
                textView.setText(textView.getText()
                        + "\n columns is empty. Wha?!");
                return false;
            } else {
                int count = 0;
                for (TableColumnList table : columns) {
                    count += table.getColumnNames().size();
                }
                if (display) {
                    textView.setText(textView.getText()
                            + "\n number of columns : " + count
                            + "\n inserting and selecting rows...");
                }
            }

            // ArrayList<String> columnNamesFor3rdTable = dbUtil
            // .getColumnNamesForTable(TABLE_NAME_3rd);
            if (display) {
                // textView.setText(textView.getText()
                // + "\n here are the column names of this table : "
                // + TABLE_NAME_3rd);
                // for (String columnNameFor3rdTable : columnNamesFor3rdTable) {
                // textView.setText(textView.getText() + "\n "
                // + columnNameFor3rdTable);
                // }
            }
            // ArrayList<String> columnDTsFor3rdTable = dbUtil
            // .getColumnDatatypesForTable(TABLE_NAME_3rd);
            if (display) {
                // textView.setText(textView.getText()
                // + "\n here are the column data types of this table : "
                // + TABLE_NAME_3rd);
                // for (String columnDTFor3rdTable : columnDTsFor3rdTable) {
                // textView.setText(textView.getText() + "\n "
                // + columnDTFor3rdTable);
                // }
            }
            Log.d("DBUtilTests", "at end of testColumns");

            return true;
        } catch (Exception e) {
            textView.setText("Error in testColumns: " + e.getMessage());
            return false;
        }
    }

    /**
     * testing selects, using TABLE_NAME_first
     */
    private boolean testSelects(boolean display) {
        try {
            boolean result = true;
            result = result && testSelectAll(display);
            // result = result && testSelectAllById(display);
            // result = result && testSelectAllWhere(display);
            return result;
        } catch (Exception e) {
            textView.setText("Error from testSelects: " + e.getMessage());
            return false;
        }
    }

    /**
     * testing select all, using TABLE_NAME_first
     */
    private boolean testSelectAll(boolean display) {
        try {
            ArrayList<Hashtable<String, String>> allRows = dbUtil
                    .getAllRows(TABLE_NAME_first);
            if (display) {
                if (allRows == null) {
                    textView.setText(textView.getText() + "\n all rows = null");
                } else {
                    textView.setText(textView.getText()
                            + "\n all rows count = " + allRows.size());
                    if (allRows.size() > 0) {
                        textView.setText(textView.getText() + "\n Rows: ");
                    }
                    for (Hashtable<String, String> row : allRows) {
                        Enumeration<String> enumKey = row.keys();
                        while (enumKey.hasMoreElements()) {
                            String key = enumKey.nextElement();
                            String val = row.get(key);
                            textView.setText(textView.getText() + "\n " + key
                                    + " = " + val);
                        }
                    }
                }
            }
            return true;
        } catch (Exception e) {
            // wrapping this in a display check clause because an error is
            // expected before inserting any rows
            if (display) {
                textView.setText(textView.getText()
                        + "\n Error from testSelectAll: " + e.getMessage());
            }
            // or we could append the error instead of overwriting everything
            return false;
        }
    }

    /**
     * testing select all by id, using TABLE_NAME_first
     */
    /*
     * private boolean testSelectAllById(boolean display) { try { // Why did I
     * make selectAll ArrayList and every other select a Hash? // This is just
     * one row, isn't it? // Oh, right, because selecting by id returns only 1
     * row // All other selects should by ArrayLists Hashtable<String, String>
     * allRows = dbUtil.getRowsById( TABLE_NAME_first, "1"); if (display) {
     * Enumeration<String> enumKey = allRows.keys(); while
     * (enumKey.hasMoreElements()) { String key = enumKey.nextElement(); String
     * val = allRows.get(key); textView.setText(textView.getText() + "\n " + key
     * + " = " + val); } } return true; } catch (Exception e) { if (display) {
     * textView.setText("Error from testSelectAllById: " + e.getMessage()); }
     * return false; } }
     */

    /**
     * testing select all by arbitrary criterion, using TABLE_NAME_first
     */
    /*
     * private boolean testSelectAllWhere(boolean display) { try {
     * ArrayList<Hashtable<String, String>> allRows = dbUtil.getRowsWhere(
     * TABLE_NAME_first, "", ""); if (display) {
     *
     * } return true; } catch (Exception e) { if (display) {
     * textView.setText("Error from testSelectAllWhere: " + e.getMessage()); }
     * return false; } }
     */

    /**
     * testing insert
     */
    private boolean testInsert() {
        try {

            Hashtable<String, String> queryValues = new Hashtable<>();

            final boolean ID_INSERT = true;
            final boolean NO_ID_INSERT = false;

            // queryValues.put("firstId", "1");
            queryValues.put("firstName", "'adam'");
            dbUtil.insertRow(TABLE_NAME_first, queryValues, NO_ID_INSERT);

            // queryValues.put("firstId", "2");
            queryValues.put("firstName", "'bob'");
            dbUtil.insertRow(TABLE_NAME_first, queryValues, NO_ID_INSERT);

            // queryValues.put("firstId", "3");
            queryValues.put("firstName", "'charlie'");
            dbUtil.insertRow(TABLE_NAME_first, queryValues, NO_ID_INSERT);

            return true;
        } catch (Exception e) {
            textView.setText("Error from testInsert: " + e.getMessage());
            return false;
        }
    }

    /**
     * testing
     */
    /*
     * private boolean test() { try {
     *
     * return true; } catch (Exception e) { textView.setText("Error from : " +
     * e.getMessage()); return false; } }
     */
}
