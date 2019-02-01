//
//  Helper.swift
//  Trybes v2
//
//  Created by Bruno Campos on 1/14/19.
//  Copyright © 2019 Bruno Campos. All rights reserved.
//

import UIKit

class Helper {
    
    //function receives email which is a String, and returns a bool type (true or false)
    //validate email address function / logic
    func isValid(email: String) -> Bool {
        
        //declaring the rule of regular expression (chars to be used). Applying the rule to current state. Verifying the result (email = rule)
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        let result = test.evaluate(with: email)
        
        return result
    }
    
    //validate name function/logic
    func isValid(name: String) -> Bool {
        
        //declaring the rule of regular expression (chars to be used). Applying the rule to current state. Verifying the result (email = rule)
        let regex = "[A-Za-z]{2,}"
        let test = NSPredicate(format: "Self Matches %@", regex)
        let result = test.evaluate(with: name)
        
        return result

    }
    
    //show alert to user
    func showAlert(title: String, message: String, from: UIViewController) {
        
        //Creating alertController: creating button to the alertController; assigningbutton to the alertController; presenting alertController
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(ok)
        from.present(alert, animated: true, completion: nil)
    }
    
    
}
