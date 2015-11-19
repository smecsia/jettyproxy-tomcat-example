package ru.qatools.example;

import org.eclipse.jetty.client.api.Response;
import org.eclipse.jetty.util.Callback;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import static java.util.concurrent.Executors.newFixedThreadPool;

/**
 * @author Ilya Sadykov
 */
@WebServlet(urlPatterns = {"/*"}, asyncSupported = true)
public class ProxyServlet extends org.eclipse.jetty.proxy.ProxyServlet {

    @Override
    public void init() throws ServletException {
        getServletContext().setAttribute("org.eclipse.jetty.server.Executor", newFixedThreadPool(100));
        super.init();
    }

    @Override
    protected void onResponseContent(HttpServletRequest request, HttpServletResponse response, Response proxyResponse, byte[] buffer, int offset, int length, Callback callback) {
        super.onResponseContent(request, response, proxyResponse, buffer, offset, length, callback);
        log("Got content from " + proxyResponse.getRequest().getURI() + " : " + length + " bytes");
    }
}
