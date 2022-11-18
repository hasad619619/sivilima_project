/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dataclass;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

/**
 *
 * @author Mayura Lakshan
 */
public class helper {
    
    public String getDate() {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Calendar cal = Calendar.getInstance();
        return dateFormat.format(cal.getTime());

    }

    public String getTime() {
        DateFormat datetime = new SimpleDateFormat("HH:mm:ss");
        Calendar cal = Calendar.getInstance();
        return datetime.format(cal.getTime());

    }
    
    public String getSecretPrice(double amount){
        String AmounString=String.valueOf(amount);
        
        AmounString = AmounString.replace("0", "Y");
        AmounString = AmounString.replace("1", "S");
        AmounString = AmounString.replace("2", "U");
        AmounString = AmounString.replace("3", "L");
        AmounString = AmounString.replace("4", "A");
        AmounString = AmounString.replace("5", "I");
        AmounString = AmounString.replace("6", "M");
        AmounString = AmounString.replace("7", "N");
        AmounString = AmounString.replace("8", "C");
        AmounString = AmounString.replace("9", "O");
        
        return AmounString;
    }
}
