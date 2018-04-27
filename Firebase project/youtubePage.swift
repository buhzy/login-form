 //
//  testVideo.swift
//  Firebase project
//
//  Created by Admin on 12/04/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class testVideo: UIViewController {

    @IBOutlet weak var test: UIWebView!
         
    override func viewDidLoad() {
        super.viewDidLoad()
         navigationItem.title = "Watch on youtube"
        
        getVideo(youtubeVideoID: "FM7MFYoylVs")
       
    }
    func getVideo(youtubeVideoID:String){
        let url = URL(string: "https://www.youtube.com/watch?v=\(youtubeVideoID)")
      test.loadRequest(URLRequest(url: url!))
    
    }
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
