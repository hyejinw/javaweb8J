package kn_brand;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface BrandInterface {
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

}
