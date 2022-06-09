package loginMember;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import conn.GetConn;
import orderList.OrderVO;

public class MemDAO {
	GetConn getConn = GetConn.getInstance();
	
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql ="";
	
	MemVO vo = null;
	OrderVO orvo = null;
	// 로그인 처리
	public MemVO LoginOk(String mid, String pwd) {
		vo = new MemVO();
		try {
			sql="select * from memberlist where mid=? and pwd =? and userDel ='NO'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				vo.setNickName(rs.getString("nickName"));
				vo.setGrade(rs.getInt("grade"));
				vo.setLastDate(rs.getString("lastDate"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		
		return vo;
	}

	public MemVO getPersonalInfor(String mid) {
		vo = new MemVO();
		try {
			sql="select * from memberlist where mid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				vo.setMid(rs.getString("mid"));
				vo.setPwd(rs.getString("pwd"));
				vo.setName(rs.getString("name"));
				vo.setNickName(rs.getString("nickName"));
				vo.setGender(rs.getString("gender"));
				vo.setTel(rs.getString("tel"));
				vo.setAddress(rs.getString("address"));
				vo.setPost(rs.getString("post"));
				vo.setEmail(rs.getString("email"));
				vo.setBirthday(rs.getString("birthday"));
				vo.setGrade(rs.getInt("grade"));
				vo.setPoint(rs.getInt("point"));
				vo.setTotPrice(rs.getInt("totPrice"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		
		return vo;
	}
	//중복아이디 체크
	public int joinIdOk(String mid) {
		int res = 0;
		try {
			sql = "select mid from memberlist where mid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				res = 1;
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return res;
	}

	public int joinEmailOk(String email) {
		int res = 0;
		try {
			sql = "select * from memberlist where email = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				res = 1;
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return res;
	}

	public int nickOk(String nickName) {
		int res = 0;
		try {
			sql = "select * from memberlist where nickName = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nickName);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				res = 1;
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return res;
	}

	public int joinOk(MemVO vo) {
		System.out.println(vo);
		int res = 0;
		try {
			sql="insert into memberlist values(default,?,?,?,?,?,?,?,?,?,default,?,default,default,default,default,0)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getMid());
			pstmt.setString(2, vo.getPwd());
			pstmt.setString(3, vo.getName());
			pstmt.setString(4, vo.getNickName());
			pstmt.setString(5, vo.getGender());
			pstmt.setString(6, vo.getTel());
			pstmt.setString(7, vo.getAddress());
			pstmt.setString(8, vo.getPost());
			pstmt.setString(9, vo.getEmail());
			pstmt.setString(10, vo.getBirthday());
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	public MemVO session(String mid) {
		vo = new MemVO();
		try {
			sql= "select * from memberlist where mid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				vo.setNickName(rs.getString("nickName"));
				vo.setGrade(rs.getInt("grade"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}

	public int pwdCheck(String mid, String pwd) {
		int res = 0;
		try {
			sql="select * from memberlist where mid=? and pwd=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				res = 1;
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return res;
	}

	public int InfoUpdateOk(MemVO vo) {
		int res = 0;
		try {
			sql="update memberlist set name=? , nickName=? , tel=? , address=? , post=? , email=? where mid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getName());
			pstmt.setString(2, vo.getNickName());
			pstmt.setString(3, vo.getTel());
			pstmt.setString(4, vo.getAddress());
			pstmt.setString(5, vo.getPost());
			pstmt.setString(6, vo.getEmail());
			pstmt.setString(7, vo.getMid());
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	public MemVO idEmailSearch(String email) {
		vo = new MemVO();
		
		try {
			sql="select * from memberlist where email = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				vo.setMid(rs.getString("mid"));
			}
			
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}

	public MemVO idSearch(String name, String tel) {
		vo = new MemVO();
		
		try {
			sql="select * from memberlist where name = ? and tel = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, tel);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				vo.setMid(rs.getString("mid"));
			}
			
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}

	public int pwdSearch(String mid, String email, String name, String tel) {
		int res = 0;
		try {
			sql="select * from memberlist where mid =? and email = ? and name = ? and tel=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setString(2, email);
			pstmt.setString(3, name);
			pstmt.setString(4, tel);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				res = 1;
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return res;
	}

	public int pwdUpdate(String mid, String pwd) {
		int res = 0;
		try {
			sql="update memberlist set pwd = ? where mid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pwd);
			pstmt.setString(2, mid);
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	public int dropMemberOk(String mid) {
		int res = 0;
		try {
			sql="update memberlist set userDel = 'OK' where mid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	public int userCount() {
		int userCount = 0;
		try {
			sql="select count(*) as cnt from memberlist";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			userCount = rs.getInt("cnt");
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return userCount;
	}

	public int delUserCount() {
		int delUserCount = 0;
		try {
			sql="select count(*) as cnt from memberlist where userDel='NO'";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			delUserCount = rs.getInt("cnt");
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return delUserCount;
	}

	public ArrayList<MemVO> getAdInfor(int startIndexNo, int pageSize) {
		ArrayList<MemVO> vos = new ArrayList<MemVO>();
		try {
			sql="select * from memberlist order by idx desc limit ?,?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startIndexNo);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MemVO vo = new MemVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setNickName(rs.getString("nickName"));
				vo.setGrade(rs.getInt("grade"));
				vo.setTotPrice(rs.getInt("totPrice"));
				vo.setUserDel(rs.getString("userDel"));
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		
		return vos;
	}

	public int prdCount() {
		int prdCount = 0;
		try {
			sql="select count(*) as cnt from product";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			prdCount = rs.getInt("cnt");
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return prdCount;
	}

	public int orderMemUpdate(MemVO memvo) {
		int res = 0;
		try {
			sql="update memberlist set totPrice = totPrice + ? , point = point + ? where mid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, memvo.getTotPrice());
			pstmt.setInt(2, memvo.getPoint());
			pstmt.setString(3, memvo.getMid());
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	public ArrayList<OrderVO> getMyorderList(String mid, int startIndexNo, int pageSize) {
		ArrayList<OrderVO> ordvos = new ArrayList<OrderVO>();
		try {
			sql="select *,(select fSName from product where name = orderlist.prdName) as fSName from orderlist where mid = ? order by idx desc limit ?,?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setInt(2, startIndexNo);
			pstmt.setInt(3, pageSize);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				orvo = new OrderVO();
				orvo.setPrdfSName(rs.getString("fSName"));
				orvo.setPrdBrand(rs.getString("prdBrand"));
				orvo.setPrdName(rs.getString("prdName"));
				orvo.setPrdOption(rs.getString("prdOption"));
				orvo.setTotPrice(rs.getInt("totPrice"));
				orvo.setSellDate(rs.getString("sellDate"));
				orvo.setOrderSw(rs.getInt("orderSw"));
				ordvos.add(orvo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return ordvos;
	}

	public int orderCount(int idx) {
		int count = 0;
		try {
			if(idx == 0) {
				sql="select count(*) as cnt from orderList";
			}
			else {
				sql="select count(*) as cnt from orderList where orderSw = 0";
			}
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt("cnt");
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return count;
	}

	public int getTotInfo(String ordMid) {
		int useTotPrice = 0;
		try {
			sql="select * from memberlist where mid =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ordMid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				useTotPrice = rs.getInt("totPrice");
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return useTotPrice;
	}

	public int setGradeUpdate(int grade, String ordMid) {
		int no = 0;
		try {
			sql="update memberlist set grade = ? where mid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, grade);
			pstmt.setString(2, ordMid);
			pstmt.executeUpdate();
			no = 1;
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return  no;
	}

	public int totRecCnt(String mid) {
		int totRecCnt = 0;
		try {
			sql="select count(*) as cnt from orderlist where mid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				totRecCnt = rs.getInt("cnt");
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return totRecCnt;
	}

	
	
	
}
