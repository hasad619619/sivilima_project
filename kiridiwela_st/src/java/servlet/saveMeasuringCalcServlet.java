/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.script.ScriptException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import resources.Items;
import resources.Type;
import resources.TypeCalc;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "saveMeasuringCalcServlet", urlPatterns = {"/saveMeasuringCalcServlet"})
public class saveMeasuringCalcServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        if (request.getParameter("t1").equals("") || request.getParameter("t1").equals("0") || request.getParameter("t2").equals("") || request.getParameter("t2").equals("0") || request.getParameter("f").equals("") || request.getParameter("item").equals("0")  || request.getParameter("item").equals("")) {

            out.print("0");

        } else {

            Session ses = connection.getConnection.getSessionFactory().openSession();
            Transaction tr = ses.beginTransaction();
            int t1 = Integer.parseInt(request.getParameter("t1"));
            int t2 = Integer.parseInt(request.getParameter("t2"));
            int t = Integer.parseInt(request.getParameter("item"));
            Type type1 = (Type) ses.load(Type.class, t1);
            Type type2 = (Type) ses.load(Type.class, t2);
            String Formula = request.getParameter("f");

            try {
                ScriptEngineManager mgr = new ScriptEngineManager();
                ScriptEngine engine = mgr.getEngineByName("JavaScript");
                String foo = "1*" + Formula + "*1";
                engine.eval(foo);

                if (t1 == t2) {
                    out.print("2");

                } else {
                    int i = 0;
                    Criteria cr = ses.createCriteria(TypeCalc.class);
                    List<TypeCalc> tc = cr.list();
                    for (TypeCalc TC : tc) {
                        if (TC.getTypeByType1().getId() == t1 && TC.getTypeByType2().getId() == t2) {
                            i = i + 1;
                        }

                    }

                    if (i == 0) {

                        Items it = (Items) ses.load(Items.class, t);
                        TypeCalc calc = new TypeCalc();
                        calc.setFormula(Formula);
                        calc.setTypeByType1(type1);
                        calc.setTypeByType2(type2);
                        calc.setItems(it);
                        ses.save(calc);
                        tr.commit();

                        out.print("1");
                        ses.close();
                    } else {

                        out.print("4");

                    }

                }

            } catch (ScriptException ex) {
                out.print("3");
            }

        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
