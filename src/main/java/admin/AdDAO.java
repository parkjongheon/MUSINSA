package admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import conn.GetConn;
import product.PrdVO;

public class AdDAO {
	GetConn getConn = GetConn.getInstance();
	
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql ="";
	
	AdVO vo = null;
	
	// 관리자페이지 상품등록
	public int setProductInput(AdVO vo) {
		int res = 0;
		try {
			sql="insert into product values(default,?,?,?,?,?,default,default,default,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getBrand());
			pstmt.setString(2, vo.getName());
			pstmt.setString(3, vo.getCategory());
			pstmt.setInt(4, vo.getrPrice());
			pstmt.setInt(5, vo.getsPrice());
			pstmt.setString(6, vo.getfName());
			pstmt.setString(7, vo.getfSName());
			pstmt.setString(8, vo.getfContent());
			pstmt.setString(9, vo.getfSContent());
			pstmt.setString(10, vo.getTagContent());
			pstmt.executeUpdate();
			res=1;
			
		} catch (Exception e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}
	// 관리자페이지 상품리스트
	public ArrayList<AdVO> getPrdList() {
		ArrayList<AdVO> vos = new ArrayList<AdVO>();
		try {
			sql="select * from product";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				vo = new AdVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setBrand(rs.getString("brand"));
				vo.setCategory(rs.getString("category"));
				vo.setName(rs.getString("name"));
				vo.setsPrice(rs.getInt("price"));
				vo.setCount(rs.getInt("count"));
				vo.setSell(rs.getInt("sell"));
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
	
	// 브랜드 등록
	public int setBrandInput(AdVO vo) {
		int res = 0;
		try {
			sql="insert into prdBrand values(default,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getBrandName());
			pstmt.setString(2, vo.getBrandFName());
			pstmt.setString(3, vo.getBrandFSName());
			pstmt.executeUpdate();
			
			res=1;
		} catch (Exception e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}
	
	// 관리자 페이지 브랜드 불러오기
	public ArrayList<AdVO> getBrandList() {
		ArrayList<AdVO> vos = new ArrayList<AdVO>();
		try {
			sql="select * from prdBrand";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new AdVO();
				vo.setBrandName(rs.getString("brandName"));
				vos.add(vo);
			}
		} catch (Exception e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}
	
	//브랜드검색으로 카테고리 뽑아오기
	public String getCategoryList(String brand) {
		String categorys = ""; 
		try {
			sql="select * from product where brandName = ? group by category";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, brand);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				categorys += rs.getString("category") + "/";
			}
		} catch (Exception e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return categorys;
	}
	public String getItemList(String brandSearch, String categorySearch) {
		String datas = "";
		System.out.println(brandSearch + categorySearch);
		try {
			sql="select * from product where brandName = ? and category = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, brandSearch);
			pstmt.setString(2, categorySearch);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				datas += rs.getString("name") + "/";
			}
			System.out.println(datas);
		} catch (Exception e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return datas;
	}
	public int brandCheck(String brand) {
		int res = 0;
		try {
			sql="select * from product where brandName = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, brand);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				res = 1;
			}
		} catch (Exception e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		
		return res;
	}
	public int setOption(AdVO vo, int index) {
		int res = 0;
		try {
			sql="insert into prdoption values(DEFAULT,(SELECT idx from product where name = ?),?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getName());
			pstmt.setString(2, vo.getColor());
			pstmt.setString(3, vo.getSize());
			pstmt.setInt(4, vo.getCount());
			pstmt.setInt(5, index);
			pstmt.executeUpdate();
			res = 1;
		} catch (Exception e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}
	
	
	
	public ArrayList<AdVO> getAllProduct(int startIndexNo, int pageSize, int part, String item) {
		ArrayList<AdVO> vos = new ArrayList<AdVO>();
		try {
			if(part == 0) {
				sql = "select * from product order by idx desc limit ?,?";				
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, startIndexNo);
				pstmt.setInt(2, pageSize);
			}
			else if(part == 1) {
				sql = "select * from product where tagContent like ? order by idx desc limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, item);
				pstmt.setInt(2, startIndexNo);
				pstmt.setInt(3, pageSize);
			}
			else if(part == 2) {
				sql = "select * from product where category = ? order by idx desc limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, item);
				pstmt.setInt(2, startIndexNo);
				pstmt.setInt(3, pageSize);
			}
			else if(part == 3) {
				sql = "select * from product where name like ? order by idx desc limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, item);
				pstmt.setInt(2, startIndexNo);
				pstmt.setInt(3, pageSize);
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				vo = new AdVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setBrandName(rs.getString("brandName"));
				vo.setCategory(rs.getString("category"));
				vo.setName(rs.getString("name"));
				vo.setsPrice(rs.getInt("sPrice"));
				vo.setrPrice(rs.getInt("rPrice"));
				vo.setSellStop(rs.getInt("sellStop"));
				vos.add(vo);
			}
			rs.close();
		} catch (Exception e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}
	public AdVO getPrdOption(int idx) {
		vo = new AdVO();
		try {
			sql="select * from product where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				vo.setfSName(rs.getString("fSName"));
				vo.setName(rs.getString("name"));
			}
		} catch (Exception e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}
	
	
	public ArrayList<AdVO> getPrdOptionAll(int idx) {
		ArrayList<AdVO> vos = new ArrayList<AdVO>();
		try {
			sql="select * from prdOption where prdIdx = ? order by color, indexCount";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new AdVO();
				vo.setColor(rs.getString("color"));
				vo.setSize(rs.getString("size"));
				vo.setCount(rs.getInt("count"));
				vo.setOpIdx(rs.getInt("idx"));
				vos.add(vo);
			}
		} catch (Exception e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}
	public int setOptionUpdate(int opValue, int opId) {
		int res = 0;
		try {
			sql="update prdOption set count = ? where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, opValue);
			pstmt.setInt(2, opId);
			pstmt.executeUpdate();
			res =1;
		} catch (Exception e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}
	public int setOptionDelete(int opIdx) {
		int res = 0;
		try {
			sql="delete from prdOption where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, opIdx);
			pstmt.executeUpdate();
			res =1;
		} catch (Exception e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}
	public int setOptionAllDelete(int opIdx) {
		int res = 0;
		try {
			sql="delete from prdOption where prdIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, opIdx);
			pstmt.executeUpdate();
			res = 1;
		} catch (Exception e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}
	public int totRecCnt(int part, String item) {
		int totRecCnt = 0;
		try {
			if(part == 0) {
				sql="select count(*) as cnt from product";				
				pstmt = conn.prepareStatement(sql);
			}
			else if(part== 1) {
				sql="select count(*) as cnt from product where tagContent like ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, item);
			}
			else if(part== 2) {
				sql="select count(*) as cnt from product where category = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, item);
			}
			else if(part== 3) {
				sql="select count(*) as cnt from product where name like ?";
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
	
	
	
	
	
	
}
