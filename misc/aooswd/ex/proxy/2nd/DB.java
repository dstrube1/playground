/**
 * @author dgayler
 *
 */

import java.sql.*;
import java.util.LinkedList;

public class DB
{

	private static Connection con;
	
	public static void init () throws Exception
	{
		Class.forName ("sun.jdbc.odbc.JdbcOdbcDriver");
		con = DriverManager.getConnection (
			"jdbc:odbc:PPP Shopping Cart");
	}
	
	public static void store (ProductData pd) throws Exception
	{
		PreparedStatement s = buildInsertionStatement (pd);
		executeStatement (s);
	}

	private static PreparedStatement buildInsertionStatement
		(ProductData pd) throws SQLException
	{
		PreparedStatement s = con.prepareStatement
			("INSERT into Products VALUES (?, ?, ?)");
		s.setString(1, pd.getSku());
		s.setString(2, pd.getName());
		s.setInt(3, pd.getPrice());
		return s;
	}
	
	public static ProductData getProductData(String sku) throws Exception
	{
		PreparedStatement s = buildProductQueryStatement(sku);
		ResultSet rs = executeQueryStatement(s);
		ProductData pd = extractProductDataFromResultSet(rs);
		rs.close();
		s.close();
		return pd;
	}
	
	private static PreparedStatement buildProductQueryStatement(String sku)
		throws SQLException
	{
		PreparedStatement s =
			con.prepareStatement("SELECT * FROM Products WHERE sku = ?;");
		s.setString(1, sku);
		return s;
	}
	
	private static ProductData extractProductDataFromResultSet
		(ResultSet rs) throws SQLException
	{
		return new ProductData(rs.getString(2), rs.getInt(3),
			rs.getString(1));
	}
	
	public static void deleteProductData(String sku) throws Exception
	{
		executeStatement(buildProductDeleteStatement(sku));
	}
	
	private static PreparedStatement buildProductDeleteStatement(String sku)
		throws SQLException
	{
		PreparedStatement s =
			con.prepareStatement("DELETE from Products where sku = ?");
		s.setString(1, sku);
		return s;
	}
	
	private static void executeStatement(PreparedStatement s)
		throws SQLException
	{
		s.execute();
		s.close();
	}
	private static ResultSet executeQueryStatement(PreparedStatement s)
		throws SQLException
	{
		ResultSet rs = s.executeQuery();
		rs.next();
		return rs;
	}
	
	public static OrderData newOrder(String customerId) throws Exception
	{
		int newMaxOrderId = getMaxOrderId() + 1;
		PreparedStatement s =
			con.prepareStatement(
				"Insert into Orders(orderId,cusid) Values(?,?);");
		s.setInt(1, newMaxOrderId);
		s.setString(2, customerId);
		executeStatement(s);
		return new OrderData(newMaxOrderId, customerId);
	}
	
	private static int getMaxOrderId() throws SQLException
	{
		Statement qs = con.createStatement();
		ResultSet rs = qs.executeQuery("Select max(orderId) from Orders;");
		rs.next();
		int maxOrderId = rs.getInt(1);
		rs.close();
		return maxOrderId;
	}
	
	public static void store(ItemData id) throws Exception
	{
		PreparedStatement s = buildItemInsersionStatement(id);
		ex