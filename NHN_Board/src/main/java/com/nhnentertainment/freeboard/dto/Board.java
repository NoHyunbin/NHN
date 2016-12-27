package com.nhnentertainment.freeboard.dto;

public class Board {
	private int bno;
	private String bemail;
	private String bpassword;
	private String bcontent;
	private String bwritetime;
	private String bmodifytime;
	
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getBemail() {
		return bemail;
	}
	public void setBemail(String bemail) {
		this.bemail = bemail;
	}
	public String getBpassword() {
		return bpassword;
	}
	public void setBpassword(String bpassword) {
		this.bpassword = bpassword;
	}
	public String getBcontent() {
		return bcontent;
	}
	public void setBcontent(String bcontent) {
		this.bcontent = bcontent;
	}
	public String getBwritetime() {
		return bwritetime.substring(0, bwritetime.length()-2);
	}
	public void setBwritetime(String bwritetime) {
		this.bwritetime = bwritetime;
	}
	public String getBmodifytime() {
		return bmodifytime.substring(0, bmodifytime.length()-2);
	}
	public void setBmodifytime(String bmodifytime) {
		this.bmodifytime = bmodifytime;
	}
	
}
