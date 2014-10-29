package jp.zyyx.training.renshuu4;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.*;
import java.time.DateTimeException;
import java.time.LocalDate;

/**
 * 登録したデータを処理するサーブレット
 */
@WebServlet("/ProcessRegisterInformation")
public class ProcessRegisterInformation extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * コンストラクター
     * @see HttpServlet#HttpServlet()
     */
    public ProcessRegisterInformation() {
        super();
    }
    
    public void doFilter(ServletRequest servletRequest,
            ServletResponse servletResponse, FilterChain filterChain)
            throws ServletException, IOException {
      servletRequest.setCharacterEncoding("UTF-8");
      filterChain.doFilter(servletRequest, servletResponse);
    }

	/**
	 * 入力したデータを処理
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		InformationBean entry = (InformationBean)session.getAttribute("entry");
		
		session.setAttribute("state", "VALID");
		
		// ユーザが編集したいなら、入力するページに戻る
		if (request.getParameter("navigate").equals("戻る")) {
			session.setAttribute("state", "EDIT");
			request.getRequestDispatcher("Register-Form.jsp").forward(request, response);
		}
		
		if (entry == null) {
			session.setAttribute("state", "INIT");
			response.sendRedirect("Register-Form.jsp");
			return;
		}
		
		// エラーがあれば、エラーメッセージを作ります
		if (entry.getName() == null || entry.getName().trim().length() == 0) {
			session.setAttribute("state", "ERROR");
			session.setAttribute("nameError", "名前を入力してください");
			
		}
		
		if (entry.getYearold() == null || !isValidYearold(entry.getYearold())) {
			session.setAttribute("state", "ERROR");
			session.setAttribute("yearoldError", "正しい年齢を入力してください");
		}
		
		if (!isDateValid(entry.getYear(), entry.getMonth(), entry.getDay())) {
			session.setAttribute("state", "ERROR");
			session.setAttribute("dateError", "正しい年月日を入力してください");
		}
		
		if ((entry.getMailAddress() == null || entry.getMailAddress().trim().length() == 0) && entry.isMailMagazine()) {
			session.setAttribute("state", "ERROR");
			session.setAttribute("mailMagazineError", "メールを入力してください");
		}
		
		if (session.getAttribute("state").toString().equals("ERROR")) {
			response.sendRedirect("Register-Form.jsp");
			return;
		} else {
			response.sendRedirect("Successful.jsp");
			return;
		}
		
	}
	
	/**
	 * 年齢が正しいかどうかをチェック
	 * @param yearold
	 * @return：　正しいならtrueを帰り、なければfalseを帰り
	 */
	public boolean isValidYearold(String yearold) {
		try {
			int number = Integer.parseInt(yearold);
			if (number <= 0) return false;
			else return true;
		} catch(NumberFormatException e) {
			return false;
		}
	}
	
	/**
	 * 年月日が存在かどうかをチェック
	 * @param year
	 * @param month
	 * @param day
	 * @return：　存在ならtrueを帰り、なければfalseを帰り
	 */
	public static boolean isDateValid(int year, int month, int day) {
	    boolean dateIsValid = true;
	    try {
	        LocalDate.of(year, month, day);
	    } catch (DateTimeException e) {
	        dateIsValid = false;
	    }
	    return dateIsValid;
	}
}
