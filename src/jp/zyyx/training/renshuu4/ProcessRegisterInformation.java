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
 * �o�^�����f�[�^����������T�[�u���b�g
 */
@WebServlet("/ProcessRegisterInformation")
public class ProcessRegisterInformation extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * �R���X�g���N�^�[
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
	 * ���͂����f�[�^������
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		InformationBean entry = (InformationBean)session.getAttribute("entry");
		
		session.setAttribute("state", "VALID");
		
		// ���[�U���ҏW�������Ȃ�A���͂���y�[�W�ɖ߂�
		if (request.getParameter("navigate").equals("�߂�")) {
			session.setAttribute("state", "EDIT");
			request.getRequestDispatcher("Register-Form.jsp").forward(request, response);
		}
		
		if (entry == null) {
			session.setAttribute("state", "INIT");
			response.sendRedirect("Register-Form.jsp");
			return;
		}
		
		// �G���[������΁A�G���[���b�Z�[�W�����܂�
		if (entry.getName() == null || entry.getName().trim().length() == 0) {
			session.setAttribute("state", "ERROR");
			session.setAttribute("nameError", "���O����͂��Ă�������");
			
		}
		
		if (entry.getYearold() == null || !isValidYearold(entry.getYearold())) {
			session.setAttribute("state", "ERROR");
			session.setAttribute("yearoldError", "�������N�����͂��Ă�������");
		}
		
		if (!isDateValid(entry.getYear(), entry.getMonth(), entry.getDay())) {
			session.setAttribute("state", "ERROR");
			session.setAttribute("dateError", "�������N��������͂��Ă�������");
		}
		
		if ((entry.getMailAddress() == null || entry.getMailAddress().trim().length() == 0) && entry.isMailMagazine()) {
			session.setAttribute("state", "ERROR");
			session.setAttribute("mailMagazineError", "���[������͂��Ă�������");
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
	 * �N����������ǂ������`�F�b�N
	 * @param yearold
	 * @return�F�@�������Ȃ�true���A��A�Ȃ����false���A��
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
	 * �N���������݂��ǂ������`�F�b�N
	 * @param year
	 * @param month
	 * @param day
	 * @return�F�@���݂Ȃ�true���A��A�Ȃ����false���A��
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
