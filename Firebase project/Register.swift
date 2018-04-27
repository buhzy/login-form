//
//  Register.swift
//  Firebase project
//
//  Created by Admin on 27/03/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
 import Firebase
class Register: UIViewController {

    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    @IBOutlet weak var repeatPassword: UITextField!
    
    @IBAction func Register(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty else {
             print("email is empty")
             ShowAlert(title: "Email", message: "is empty")
            return
           
        }
        guard let password = Password.text, !password.isEmpty else {
            print("password is empty ")
             ShowAlert(title: "password", message: "is empty")
            return
            
        }
  
        guard let reppassword = repeatPassword.text, !reppassword.isEmpty else {
                print("reapt password is empty")
              ShowAlert(title: "repeat password", message: "is empty")
            return
        }
        guard password == reppassword else {
            self.ShowAlert(title: "passwords", message: "don't match")
              print("passwords don't match")
            return
        }
        
        
        
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            // ...
            if let error = error {
                print(error)
                if error._code == 17026 {
                    // password should be at least 6 characters
                    let alert = UIAlertController(title: "password error", message: "password should be at least 6 chracters ", preferredStyle: .alert)
                      alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                  self.present(alert, animated: true, completion: nil)
                }
              
            
            }
            }
    }
            
        

    

    
  override func viewDidLoad() {
        super.viewDidLoad()

      
    }


    
}
