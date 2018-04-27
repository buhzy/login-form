//
//  commentsVC.swift
//  Firebase project
//
//  Created by Admin on 01/04/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class commentsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

 
    @IBAction func runTransaction(_ sender: UIButton) {
        let ref = Database.database().reference().child("comments/posts/seen")
        ref.runTransactionBlock { (data) -> TransactionResult in
            let result = data
            if var value = data.value as? Int {
                value += 1
                result.value = value
                print("oldvalue:\(value)")
                return TransactionResult.success(withValue: result)
            }
            
            result.value = 1
            print("inital cal:\(result.value)")
            return TransactionResult.success(withValue: result)
        }
        
    }
    
    
    
    
    
    
    
    
    @IBAction func SendComment(_ sender: UIButton) {
        

    let alert = UIAlertController(title: "Enter", message: "message", preferredStyle: .alert)
        alert.addTextField { (tf:UITextField) in
            tf.placeholder = "Message"
            
        }
        alert.addAction(UIAlertAction(title: "Send", style: .default, handler: { (action:UIAlertAction) in
            if let text = alert.textFields?.first?.text, !text.isEmpty {
                // upload comment to firebase
             self.upload(comment: text)
             
            }
        }))
         alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
         self.present(alert, animated: true, completion: nil)
    
    }
        
    @IBAction func GoOffline(_ sender: UIButton) {
      Database.database().goOffline()
    }
    
    @IBAction func GoOnline(_ sender: UIButton) {
    Database.database().goOnline()
    }
    
    // upload comments string to firebase database
    private func upload(comment:String) {
//         let ref = Database.database().reference().child("comments/group1")
//         let new = ref.childByAutoId()
//        ref.setValue(["comment":comment])
//
//
        
        
   }


    
    
    
    
    

}
        
        
        
        
        




        // just experiments
        
        

        
        
        // create an auto id
       //let newchild =  ref.childByAutoId()
        //ref.setValue(["abdo","jady","sondos"])
        
        // update child valuse
        //ref.updateChildValues(["age":12,"job":"android developer"])
        
        // this is another methdo to update child value
        //ref.child("age").setValue(45)
        
        
        // use completion handler
        /*ref.child("age").setValue(85) { (error,Datarefrence ) in
            if let error = error{
                print(error)
            }else {
                print("succeed")
            }
        }
         */
        
//
//        let timestamp = ServerValue.timestamp()
//        ref.child("created").setValue(timestamp)
        
/* this is another way to remove items btw nsnull is like nil in this part if cannot use nil use nsnull
        ref.updateChildValues(["age":35,"job":NSNull()])
        */

        
        
        
        
        
//        let time = 1522694098973
//        let date = NSDate(timeIntervalSince1970: TimeInterval(time/1000))
//
//        print(date)
//        let dateformatter = DateFormatter()
//        dateformatter.locale = NSLocale.current
//        dateformatter.dateStyle = .short
//        dateformatter.timeStyle = .short
////        dateformatter.timeZone = NSTimeZone(abbreviation: "GMT+2")
//
//        print(dateformatter.string(from: date as Date))
//
    

    
  
    
    
    
    
    
    
    
    

