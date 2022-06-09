package product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import conn.GetConn;

public class PrdDAO {
	GetConn getConn = GetConn.getInstance();
	
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql ="";
	
	PrdVO vo = null;

	public ArrayList<PrdVO> productMain(int startIndexNo, int pageSize, int part, String item) {
		ArrayList<PrdVO> vos = new ArrayList<PrdVO>();
		try {
			if(part == 0) {
				sql="select * from product order by idx desc limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, startIndexNo);
				pstmt.setInt(2, pageSize);
			}
			else if(part == 1) {
				sql="select * from product where category ='상의' order by idx desc limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, startIndexNo);
				pstmt.setInt(2, pageSize);
			}
			else if(part == 2) {
				sql="select * from product where category ='아우터' order by idx desc limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, startIndexNo);
				pstmt.setInt(2, pageSize);
			}
			else if(part == 3) {
				sql="select * from product where category ='하의' order by idx desc limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, startIndexNo);
				pstmt.setInt(2, pageSize);
			}
			else if(part == 4) {
				sql="select * from product where category ='스커트' order by idx desc limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, startIndexNo);
				pstmt.setInt(2, pageSize);
			}
			else if(part == 5) {
				sql="select * from product where tagContent like ? order by idx desc limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, item);
				pstmt.setInt(2, startIndexNo);
				pstmt.setInt(3, pageSize);
			}
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new PrdVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setBrandName(rs.getString("brandName"));
				vo.setName(rs.getString("name"));
				vo.setsPrice(rs.getInt("sPrice"));
				vo.setfSName(rs.getString("fSName"));
				vo.setSellStop(rs.getInt("sellStop"));
				vos.add(vo);
			}
		} catch (Exception e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}

	public int totRecCnt(int part, String item) {
		int totRecCnt = 0;
		try {
			if(part == 0) {
				sql="select count(*) as cnt from product";
				pstmt = conn.prepareStatement(sql);
			}
			else if(part== 1) {
				sql="select count(*) as cnt from product where category ='상의'";
				pstmt = conn.prepareStatement(sql);
			}
			else if(part== 2) {
				sql="select count(*) as cnt from product where category ='아우터'";
				pstmt = conn.prepareStatement(sql);
			}
			else if(part== 3) {
				sql="select count(*) as cnt from product where category ='하의'";
				pstmt = conn.prepareStatement(sql);
			}
			else if(part== 4) {
				sql="select count(*) as cnt from product where category ='스커트'";
				pstmt = conn.prepareStatement(sql);
			}
			else if(part==5) {
				sql="select count(*) as cnt from product where tagContent like ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, item);
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

	public PrdVO prdProduct(int idx) {
		try {
			vo = new PrdVO();
			sql="select * from product where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				vo.setIdx(rs.getInt("idx"));
				vo.setBrandName(rs.getString("brandName"));
				vo.setName(rs.getString("name"));
				vo.setCategory(rs.getString("category"));
				vo.setsPrice(rs.getInt("sPrice"));
				vo.setfSName(rs.getString("fSName"));
				vo.setSell(rs.getInt("sell"));
				vo.setfSContent(rs.getString("fSContent"));
				vo.setTagContent(rs.getString("tagContent"));
			}
		} catch (Exception e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		
		return vo;
	}

	public ArrayList<PrdVO> prdProductOption(int idx) {
		ArrayList<PrdVO> vos = new ArrayList<PrdVO>();
		
		try {
			sql="select * from prdOption where prdIdx = ? group by color";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				vo = new PrdVO();
				vo.setColor(rs.getString("color"));
				vos.add(vo);
			}
		} catch (Exception e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}

	public ArrayList<PrdVO> prdProductOptionColor(int idx) {
		ArrayList<PrdVO> cvos = new ArrayList<PrdVO>();
		try {
			sql="select * from prdOption where prdIdx=? order by indexCount";
			pstmt =conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				vo = new PrdVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setSize(rs.getString("size"));
				cvos.add(vo);
			}
		} catch (Exception e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return cvos;
	}

	public PrdVO prdProductColor(int idx) {
		vo = new PrdVO();
		try {
			sql="select * from prdOption where prdIdx = ? group by color";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				vo.setColor(rs.getString("color"));
			}
		} catch (Exception e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}

	public String sizeSearch(int idx, String color) {
		String res = "";
		try {
			sql="select * from prdOption where prdIdx = ? and color = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.setString(2, color);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				res += (rs.getInt("idx")+"_"+rs.getString("size")+"/");
			}
		} catch (Exception e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return res;
	}

	public ArrayList<PrdVO> getSellOption(String tot) {
		ArrayList<PrdVO> vos = new ArrayList<PrdVO>();
		try {
				sql = "select * from prdOption where idx = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, tot);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					vo = new PrdVO();
					vo.setIdx(rs.getInt("idx"));
					vo.setColor(rs.getString("color"));
					vo.setSize(rs.getString("size"));
					vos.add(vo);
				}
			
		} catch (Exception e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}

	public int setSellCount(String ordPrdName, int prdCount) {
		int res = 0;
		try {
			sql="update product set sell = sell + ? where name = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, prdCount);
			pstmt.setString(2, ordPrdName);
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
