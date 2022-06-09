package orderList;

public class OrderVO {
	
	private int idx;
	private String mid;
	private String sellName;
	private String prdBrand;
	private String prdName;
	private String prdOption;
	private String pickName;
	private String pickTel;
	private String pickAddress;
	private String pickPost;
	private String pickMemo;
	private String sellDate;
	private int totPrice;
	private int orderSw;
	private String prdfSName;
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
	public String getSellName() {
		return sellName;
	}
	public void setSellName(String sellName) {
		this.sellName = sellName;
	}
	public String getPrdBrand() {
		return prdBrand;
	}
	public void setPrdBrand(String prdBrand) {
		this.prdBrand = prdBrand;
	}
	public String getPrdName() {
		return prdName;
	}
	public void setPrdName(String prdName) {
		this.prdName = prdName;
	}
	public String getPrdOption() {
		return prdOption;
	}
	public void setPrdOption(String prdOption) {
		this.prdOption = prdOption;
	}
	public String getPickName() {
		return pickName;
	}
	public void setPickName(String pickName) {
		this.pickName = pickName;
	}
	public String getPickTel() {
		return pickTel;
	}
	public void setPickTel(String pickTel) {
		this.pickTel = pickTel;
	}
	public String getPickAddress() {
		return pickAddress;
	}
	public void setPickAddress(String pickAddress) {
		this.pickAddress = pickAddress;
	}
	public String getPickPost() {
		return pickPost;
	}
	public void setPickPost(String pickPost) {
		this.pickPost = pickPost;
	}
	public String getPickMemo() {
		return pickMemo;
	}
	public void setPickMemo(String pickMemo) {
		this.pickMemo = pickMemo;
	}
	public String getSellDate() {
		return sellDate;
	}
	public void setSellDate(String sellDate) {
		this.sellDate = sellDate;
	}
	public int getTotPrice() {
		return totPrice;
	}
	public void setTotPrice(int totPrice) {
		this.totPrice = totPrice;
	}
	public int getOrderSw() {
		return orderSw;
	}
	public void setOrderSw(int orderSw) {
		this.orderSw = orderSw;
	}
	public String getPrdfSName() {
		return prdfSName;
	}
	public void setPrdfSName(String prdfSName) {
		this.prdfSName = prdfSName;
	}
	@Override
	public String toString() {
		return "OrderVO [idx=" + idx + ", mid=" + mid + ", sellName=" + sellName + ", prdBrand=" + prdBrand + ", prdName="
				+ prdName + ", prdOption=" + prdOption + ", pickName=" + pickName + ", pickTel=" + pickTel + ", pickAddress="
				+ pickAddress + ", pickPost=" + pickPost + ", pickMemo=" + pickMemo + ", sellDate=" + sellDate + ", totPrice="
				+ totPrice + ", orderSw=" + orderSw + ", prdfSName=" + prdfSName + "]";
	}
	
	
}
