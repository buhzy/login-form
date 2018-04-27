//
//  MainVC.swift
//  Firebase project
//
//  Created by Admin on 27/03/2018.
//  Copyright © 2018 Admin. All rights reserved.
//


import UIKit
import Firebase

class MainVC: UIViewController {
    
    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var PhotoUrl: UITextField!
    @IBOutlet weak var EmailVerified: UILabel!
    
    @IBOutlet weak var VerifyEmail: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "log out", style: .plain, target: self, action: #selector(logout))
        
    }
    @objc func logout(){
        do{
            try Auth.auth().signOut()
            print("logged out")
        } catch{
            print(error)
        }
        
    }
    
    
    private func loadData(){
        if let user = Auth.auth().currentUser {
            user.reload(completion: { (error) in
                if let error = error{
                    print(error)
                }else {
                    // to show your email on the screen
                    if let email = user.email{
                        self.navigationItem.title = email
                    }
                    if let name = user.displayName {
                        self.Name.text = name
                    }
                    if user.isEmailVerified{
                        self.EmailVerified.text = "email verified"
                        self.EmailVerified.textColor = UIColor.blue
                        self.VerifyEmail.isHidden = true
                    }else {
                        self.EmailVerified.text = "email not verified"
                        self.EmailVerified.textColor = UIColor.red
                        self.VerifyEmail.isHidden = false
                    }
                    if let photoUrl = user.photoURL {
                        self.PhotoUrl.text = photoUrl.absoluteString
                        
                        // Download photo
                        URLSession.shared.dataTask(with: photoUrl, completionHandler: { (NSData,URLResponse, error) in
                            if let error = error {
                                self.ShowAlert(title:"error" , message: error.localizedDescription)
                            }else{
                                if let data = NSData, let Image = UIImage(data:data){
                                    DispatchQueue.main.async {
                                        self.ImageView.image = Image
                                    }
                                    
                                    
                                    
                                }
                            }
                        }).resume()
                    }
                }
            })
            
            
            
        }
    }
    
    @IBAction func Update(_ sender: UIButton) {
        guard let user = Auth.auth().currentUser else { return}
        
        let name = Name.text!
        let photoUrl =  PhotoUrl.text!
        
        let changeRequest  = user.createProfileChangeRequest()
        changeRequest.displayName = name
        changeRequest.photoURL = NSURL(string: photoUrl) as! URL
        
        changeRequest.commitChanges { (error) in
            if let error = error {
                self.ShowAlert(title:"error", message: error.localizedDescription)
            } else {
                self.ShowAlert(title: "succeed", message: "user profile updated")
                self.loadData()
                
                
            }
        }
        
    }
    
    // update email,password , delete account
    @IBAction func UpdateEmail(_ sender: UIButton) {
        
        guard let user = Auth.auth().currentUser else { return}
        
        
        let alert = UIAlertController(title: "Enter", message: "New Email", preferredStyle: .alert)
        alert.addTextField { (tf:UITextField) in
            tf.placeholder = "New Email"
        }
        alert.addTextField { (tf:UITextField) in
            tf.placeholder = "current Email"
        }
        alert.addTextField { (tf:UITextField) in
            tf.placeholder = "current password"
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { (action:UIAlertAction) in
            if let textField = alert.textFields {
                let newEmail = textField.first!.text
                let currentEmail = textField[1].text
                let password = textField[2].text
                
                user.updateEmail(to: newEmail!, completion: { (error) in
                    // handle other errors
                    if let error = error {
                        
                        self.ShowAlert(title: "Error", message: error.localizedDescription)
                        if error._code == 17014 {
                            // required recent authentication
                            
                          
                        }
                    }else {
                        self.ShowAlert(title: "succeed", message: "mail Updated")
                    }
                })
            }
            
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func VerifyButton(_ sender: UIButton) {
        // send email verification to the user
        guard let user = Auth.auth().currentUser else {
            return
        }
        user.sendEmailVerification { (error) in
            if let error = error {
                self.ShowAlert(title: "error", message: error.localizedDescription)
            }else{
                self.ShowAlert(title: "succeed", message: "check your inbox for verification link")
            }
        }
    }
    
    @IBAction func UpdatePassword(_ sender: UIButton) {
        guard let user = Auth.auth().currentUser else { return}
        
        
        let alert = UIAlertController(title: "Enter", message: "New password", preferredStyle: .alert)
        alert.addTextField { (tf:UITextField) in
            tf.placeholder = "New password"
            tf.isSecureTextEntry = true
        }
        alert.addTextField { (tf:UITextField) in
            tf.placeholder = "current Email"
           
        }
        alert.addTextField { (tf:UITextField) in
            tf.placeholder = "current password"
            tf.isSecureTextEntry = true
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { (action:UIAlertAction) in
            if let textField = alert.textFields {
                let newPassword = textField.first!.text
                let currentEmail = textField[1].text
                let password = textField[2].text
                
                user.updatePassword(to: newPassword!, completion: { (error) in
                    // handle other errors
                    if let error = error {
                        
                        self.ShowAlert(title: "Error", message: error.localizedDescription)
                        if error._code == 17014 {
                            // required recent authentication
                             print(error.localizedDescription)
                            
                        }
                    }else {
                        
                        self.ShowAlert(title: "succeed", message: "password Updated")
                    }
                })
            }
            
        }))
        self.present(alert, animated: true, completion: nil)    }
    
    @IBAction func DeleteAccount(_ sender: UIButton) {
    
        guard let user = Auth.auth().currentUser else { return}
        
        
        let alert = UIAlertController(title: "Enter", message: "New Email", preferredStyle: .alert)
        
        alert.addTextField { (tf:UITextField) in
            tf.placeholder = "current Email"
        }
        alert.addTextField { (tf:UITextField) in
            tf.placeholder = "current password"
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Delete Account", style: .default, handler: { (action:UIAlertAction) in
            if let textField = alert.textFields {
                
                let currentEmail = textField[0].text
                let password = textField[1].text
                
                user.delete(completion: { (error) in
                
                    // handle other errors
                    if let error = error {
                        
                        self.ShowAlert(title: "Error", message: error.localizedDescription)
                        if error._code == 17014 {
                            // required recent authentication
                              print(error.localizedDescription)
                        }
                    }else {
                        self.ShowAlert(title: "succeed", message: "Account Deleted")
                    }
                })
            }
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}









//http://pkulak-nibbler-test.s3.amazonaws.com/bojack.png
// s3.amzonaws.com/aelzohry/me.jpg

