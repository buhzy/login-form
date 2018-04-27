//
//  ViewController.swift
//  Firebase project
//
//  Created by Admin on 26/03/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

import Firebase
import FBSDKLoginKit

class ViewController: UIViewController,FBSDKLoginButtonDelegate {
          var counter = 0
    @IBOutlet weak var Facebooklogin: FBSDKLoginButton!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var Email: UITextField!
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func Forgotpassword(_ sender: UIButton) {
              //Reset password
         let alert = UIAlertController(title: "Enter", message: "your email", preferredStyle: .alert)
        alert.addTextField { (tf:UITextField) in
            tf.placeholder = "Email"
            tf.keyboardType = .emailAddress
            alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (action:UIAlertAction) in
                if let email = alert.textFields?.first?.text, !email.isEmpty {
                    Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
                        if let error = error {
                            self.ShowAlert(title: "Error", message: error.localizedDescription)
                        }else {
                            self.ShowAlert(title: "Check", message: "your inbox for details")
                        }
                    })
                }
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
        
        
    
    
    }
    @IBAction func login(_ sender: UIButton) {
        guard let email = Email.text, !email.isEmpty else {
            self.ShowAlert(title: "invalid email", message: "email is empty")
          
            return
            
        }
        guard let password = Password.text, !password.isEmpty else {
           self.ShowAlert(title: "invalid password", message: "password empty")
            return
        }
        self.view.endEditing(true)
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if let error = error {
                print(error.localizedDescription)
                
                if error._code == 17011 {
                    // user not found
                    self.ShowAlert(title: "not found", message: "user not found")
                }else if error._code == 17009 {
                    // password is invalid
                    self.ShowAlert(title: "Error", message: "password is invalid")
                }
            } else {
                if let user = user {
                    print(user)
                    
                  
                }
            }
            self.showBloack()
            // ...
        }
    }
    
    func showBloack(){
        
         counter += 1
    let alert = UIAlertController(title: "Block", message: "you're screen block  for 30 seconds", preferredStyle: .alert)
       
       // lock the screen if the user enter the password 3 times wrong
      if counter == 3 {
         self.present(alert, animated: true, completion: nil)
        
        Timer.scheduledTimer(withTimeInterval: 30, repeats: false, block: { (time) in
              alert.dismiss(animated: true, completion: nil)
        })
        }
      
        
        
        
    }
            
//       counter += 1
//
//        let alert = UIAlertController(title: "Block", message: "you're screen block for 30 seconds", preferredStyle: .alert)
//          self.present(alert, animated: true, completion: nil)
//
//             //Block screen for 30 seconds after 3 times wrong
//
//        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { (time) in
//             alert.dismiss(animated: true, completion: nil)
//
//
//        }
        
    
    
    
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("facebook user logged out ")
    }
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        // the user complete login
        if let error = error {
        self.ShowAlert(title: "Error", message: error.localizedDescription)
        }else {
            if !result.isCancelled {
            let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                if let error = error{
                    self.ShowAlert(title: "Error", message: error.localizedDescription)
                }else if let user = user {
                     print(user.displayName)
                      print(user.uid)
                      print(user.email)
                      print(user.photoURL)
                    print("User logged in")
                     self.ShowAlert(title: "User", message: "logged in")
                }
            })
            } else{
                
                self.ShowAlert(title: "Error", message: "user Cancelled")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Facebooklogin.delegate = self
    }


}

