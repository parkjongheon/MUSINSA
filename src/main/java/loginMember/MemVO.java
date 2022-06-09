package loginMember;

public class MemVO {
	private int idx;
	private String mid;
	private String pwd;
	private String name;
	private String nickName;
	private String gender;
	private String tel;
	private String address;
	private String post;
	private String email;
	private String joinDay;
	private String birthday;
	private int grade;
	private int point;
	private String userDel;
	private String lastDate;
	private int totPrice;
	private int applyDiff;		// 날짜 차이를 저장하는 필드
	private String strGrade;	// 회원등급을 문자로 저장하는 필드
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPost() {
		return post;
	}
	public void setPost(String post) {
		this.post = post;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getJoinDay() {
		return joinDay;
	}
	public void setJoinDay(String joinDay) {
		this.joinDay = joinDay;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public String getUserDel() {
		return userDel;
	}
	public void setUserDel(String userDel) {
		this.userDel = userDel;
	}
	public String getLastDate() {
		return lastDate;
	}
	public void setLastDate(String lastDate) {
		this.lastDate = lastDate;
	}
	public int getTotPrice() {
		return totPrice;
	}
	public void setTotPrice(int totPrice) {
		this.totPrice = totPrice;
	}
	public int getApplyDiff() {
		return applyDiff;
	}
	public void setApplyDiff(int applyDiff) {
		this.applyDiff = applyDiff;
	}
	public String getStrGrade() {
		return strGrade;
	}
	public void setStrGrade(String strGrade) {
		this.strGrade = strGrade;
	}
	@Override
	public String toString() {
		return "MemVO [idx=" + idx + ", mid=" + mid + ", pwd=" + pwd + ", name=" + name + ", nickName=" + nickName
				+ ", gender=" + gender + ", tel=" + tel + ", address=" + address + ", post=" + post + ", email=" + email
				+ ", joinDay=" + joinDay + ", birthday=" + birthday + ", grade=" + grade + ", point=" + point + ", userDel="
				+ userDel + ", lastDate=" + lastDate + ", totPrice=" + totPrice + ", applyDiff=" + applyDiff + ", strGrade="
				+ strGrade + "]";
	}
	
	
	
}
