package jp.zyyx.training.renshuu4;

import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;

/**
 * 登録のデータのビーン
 * @author thangvm
 *
 */
public class InformationBean {
	private String name = "";
	private String yearold = "";
	private int year = 0;
	private int month = 0;
	private int day = 0;
	private String mailAddress = "";
	private boolean mailMagazine = false;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = convertString(name);
	}
	public String getYearold() {
		return yearold;
	}
	public void setYearold(String yearold) {
		this.yearold = convertString(yearold);
	}
	
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public int getMonth() {
		return month;
	}
	public void setMonth(int month) {
		this.month = month;
	}
	public int getDay() {
		return day;
	}
	public void setDay(int day) {
		this.day = day;
	}
	public String getMailAddress() {
		return mailAddress;
	}
	public void setMailAddress(String mailAddress) {
		this.mailAddress = mailAddress;
	}
	public boolean isMailMagazine() {
		return mailMagazine;
	}
	public void setMailMagazine(boolean mailMagazine) {
		this.mailMagazine = mailMagazine;
	}

	public String toString() {
		return "Name: " + name + "<br>Yearold: " + yearold + 
				"<br>Year: " + year + " Montn: " + month + " Day: " + day +
				"<br>Mailadress: " + mailAddress +
				"<br>Mail Magazine " + mailMagazine;
	}
	
	private String convertString(String str) {
		str = str.replace("&", "&amp;");
		str = str.replace("<", "&lt;");
		str = str.replace(">", "&gt;");
		str = str.replace("\"", "&quot;");
		str = str.replace("\'", "apos;");
		return str;
	}
}
