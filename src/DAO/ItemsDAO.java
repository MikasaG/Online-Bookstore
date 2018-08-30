package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import Entity.Items;
import Tools.DB_ConnectionGetter;

public class ItemsDAO {
		
	public ArrayList<Items> getAllItems() {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		ArrayList<Items> list = new ArrayList<Items>();
		try{
			conn = DB_ConnectionGetter.getConnection();	
			String sql = "select * from items;";
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Items item = new Items();
				item.setId(rs.getInt("id"));
				item.setName(rs.getString("name"));
				item.setStock(rs.getInt("stock"));
				item.setOrigin(rs.getString("origin"));
				item.setPic(rs.getString("pic"));
				item.setPrice(rs.getInt("price"));
				list.add(item);
			}
			return list;
		}catch(Exception e){
			System.out.println("error in getAllItems()");
			e.getMessage();
			return null;
		}finally {
			// release resource.
			if (rs !=null) {
				try{
					rs.close();
					rs = null;
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			if (stmt !=null) {
				try{
					stmt.close();
					stmt = null;
				}catch(Exception e){
					e.printStackTrace();
				}
			}
		}
	}
	
	public Items getItemsById(int id) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try{
			conn = DB_ConnectionGetter.getConnection();	
			String sql = "select * from items where id = ?;";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, id);
			rs = stmt.executeQuery();
			if(rs.next()) {
				Items item = new Items();
				item.setId(rs.getInt("id"));
				item.setName(rs.getString("name"));
				item.setStock(rs.getInt("stock"));
				item.setOrigin(rs.getString("origin"));
				item.setPic(rs.getString("pic"));
				item.setPrice(rs.getInt("price"));
				return item;
			} else {
				return null;
			}
		}catch(Exception e){
			System.out.println("error in gettemsById()");
			e.getMessage();
			return null;
		}finally {
			// release resource.
			if (rs !=null) {
				try{
					rs.close();
					rs = null;
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			if (stmt !=null) {
				try{
					stmt.close();
					stmt = null;
				}catch(Exception e){
					e.printStackTrace();
				}
			}
		}
	}
	
	public ArrayList<Items> getViewedList(String list, int iCount)
	{
		ArrayList<Items> itemlist = new ArrayList<Items>();
		if(list!=null&&list.length()>0)
		{
		    String[] arr = list.split("#");
		    if(arr.length>=iCount)
		    {
		       for(int i=arr.length-1;i>=arr.length-iCount;i--)
		       {
		    	  itemlist.add(getItemsById(Integer.parseInt(arr[i])));  
		       }
		    } else {
		    	for(int i=arr.length-1;i>=0;i--)
		    	{
		    		itemlist.add(getItemsById(Integer.parseInt(arr[i])));
		    	}
		    }
		    return itemlist;
		}else{
			return null;
		}
	}
}
