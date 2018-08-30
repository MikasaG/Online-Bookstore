package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.ItemsDAO;
import Entity.Cart;
import Entity.Items;

public class CartServlet extends HttpServlet {
	private String action;// add,show,delete.
	private ItemsDAO idao = new ItemsDAO();
	/**
		 * Constructor of the object.
		 */
	public CartServlet() {
		super();
	}

	/**
		 * Destruction of the servlet. <br>
		 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
		 * The doGet method of the servlet. <br>
		 *
		 * This method is called when a form has its tag value method equals to get.
		 * 
		 * @param request the request send by the client to the server
		 * @param response the response send by the server to the client
		 * @throws ServletException if an error occurred
		 * @throws IOException if an error occurred
		 */
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doPost(request,response);
	}

	/**
		 * The doPost method of the servlet. <br>
		 *
		 * This method is called when a form has its tag value method equals to post.
		 * 
		 * @param request the request send by the client to the server
		 * @param response the response send by the server to the client
		 * @throws ServletException if an error occurred
		 * @throws IOException if an error occurred
		 */
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		if (request.getParameter("action") != null) {
			this.action = request.getParameter("action");
			if (action.equals("add")) { // if user want to add item to cart
				if (addToCart(request,response)) {
					request.getRequestDispatcher("/success.jsp").forward(request, response);
				} else {
					request.getRequestDispatcher("/failure.jsp").forward(request, response);
				}
			} else if (action.equals("show")) {// if user want to check cart.
				request.getRequestDispatcher("/cart.jsp").forward(request,response);
			} else if (action.equals("delete")) {// if user want to delete an item.
				if (deleteFromCart(request,response)) {
					System.out.println("can b here");
					request.getRequestDispatcher("/cart.jsp").forward(request, response);
				} else {
					request.getRequestDispatcher("/cart.jsp").forward(request, response);
				}
			}
		}
	}
	
	private boolean addToCart (HttpServletRequest request, HttpServletResponse response) {
		Cart cart;
		String id = request.getParameter("id");
		String quantity = request.getParameter("quantity");
		Items item = idao.getItemsById(Integer.parseInt(id));
		if(request.getSession().getAttribute("cart") == null) {
			cart = new Cart();
			request.getSession().setAttribute("cart", cart);
		} else {
			cart = (Cart)request.getSession().getAttribute("cart");
		}
		if(cart.addItem(item, Integer.parseInt(quantity))) {
			request.setAttribute("name", item.getName());
			return true;
		} else {
			return false;
		}
	}

	private boolean deleteFromCart(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		Cart cart = (Cart)request.getSession().getAttribute("cart");
		Items item = idao.getItemsById(Integer.parseInt(id));
		if (cart.removeItem(item)) {
			return true;
		} else {
			return false;
		}
		
		
	}
	/**
		 * Initialization of the servlet. <br>
		 *
		 * @throws ServletException if an error occurs
		 */
	public void init() throws ServletException {
		// Put your code here
	}

}
