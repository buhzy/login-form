//
//  update.swift
//  Firebase project
//
//  Created by Admin on 28/03/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
extension UIViewController {
    func ShowAlert(title:String,message : String ,okTitle : String = "OK") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
         alert.addAction(UIAlertAction(title: okTitle, style: .cancel, handler: nil))
      
        self.present(alert, animated: true, completion: nil)
        
    }
}

