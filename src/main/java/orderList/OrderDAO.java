package orderList;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import conn.GetConn;

public class OrderDAO {
	GetConn getConn = GetConn.getInstance();
	
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql ="";
	
	OrderVO vo = null;

	public int setCountUpdate(String opIdx, String count) {
		int res =0;
		int opIdxs = Integer.parseInt(opIdx);
		int counts = Integer.parseInt(count);
		try {
			sql="update prdOption set count = count - ? where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, counts);
			pstmt.setInt(2, opIdxs);
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("SQL에러 : "+ e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
		
	}

	public int setOrderList(OrderVO orvo) {
		int res = 0;
		try {
			sql="insert into orderlist values(default,?,?,?,?,?,?,?,?,?,?,?,default,default)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, orvo.getMid());
			pstmt.setString(2, orvo.getSellName());
			pstmt.setString(3, orvo.getPrdBrand());
			pstmt.setString(4, orvo.getPrdName());
			pstmt.setString(5, orvo.getPrdOption());
			pstmt.setString(6, orvo.getPickName());
			pstmt.setString(7, orvo.getPickTel());
			pstmt.setString(8, orvo.getPickAddress());
			pstmt.setString(9, orvo.getPickPost());
			pstmt.setString(10, orvo.getPickMemo());
			pstmt.setInt(11, orvo.getTotPrice());
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("SQL에러 : "+ e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	public int totRecCnt(int part) {
		int totRecCnt = 0;
		try {
			if(part == 0) {
				sql="select count(*) as cnt from orderlist";				
				pstmt = conn.prepareStatement(sql);
			}
			else{
				sql="select count(*) as cnt from orderlist where orderSw = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, part);
			}
			rs = pstmt.executeQuery();			
			rs.next();
			totRecCnt = rs.getInt("cnt");
		} catch (Exception e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return totRecCnt;
	}

	public ArrayList<OrderVO> getOrderList(int startIndexNo, int pageSize, int part) {
		ArrayList<OrderVO> vos = new ArrayList<OrderVO>();
		try {
			if(part == 0) {
				sql="select * from orderlist order by idx desc limit ?,?";				
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, startIndexNo);
				pstmt.setInt(2, pageSize);
			}
			else {
				sql="select * from orderlist where orderSw = ? order by idx desc limit ?,?";				
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, part);
				pstmt.setInt(2, startIndexNo);
				pstmt.setInt(3, pageSize);
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				vo = new OrderVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setSellName(rs.getString("sellName"));
				vo.setPickAddress(rs.getString("pickAddress"));
				vo.setPickPost(rs.getString("pickPost"));
				vo.setPrdName(rs.getString("prdName"));
				vo.setPrdOption(rs.getString("prdOption"));
				vo.setPickName(rs.getString("pickName"));
				vo.setTotPrice(rs.getInt("totPrice"));
				vo.setOrderSw(rs.getInt("orderSw"));
				vos.add(vo);
			}
		} catch (Exception e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}

	public int setOrderUpdate(int idx, int info) {
		int res = 0;
		try {
			sql="update orderList set orderSw = ? where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, info);
			pstmt.setInt(2, idx);
			pstmt.executeUpdate();
			res = 1;
		} catch (Exception e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	

}
