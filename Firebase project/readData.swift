//
//  readData.swift
//  Firebase project
//
//  Created by Admin on 12/04/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class readData: UITableViewController {
    private let cellIdentifier = "cell"
    var contacts = [String]()
    let ref = Database.database().reference().child("contacts")
    override func viewDidLoad() {
        super.viewDidLoad()
           //add item
        navigationItem.title = "contacts"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addHandler))
           //Read Data
        tableView.register(UITableViewCell.self, forCellReuseIdentifier:cellIdentifier)
        
        loadData()
    }
    private func loadData(){
        // observe the data repeatedly
        ref.observe(.value) { (DataSnapshot) in
            if let names = DataSnapshot.value as? [String:AnyObject] {
                  self.contacts = []
                for value in names.values {
                    if let contact = value["contact"] as? String {
                        self.contacts.append(contact)
                    }
                }
                
            }
            self.tableView.reloadData()
            // print(DataSnapshot)
        }
      }
    
        /// observe data once
    func singleObserve(){
        // .value to get all the data from the database
        ref.observeSingleEvent(of:.value, with: { (DataSnapshot) in
            if let names = DataSnapshot.value as? [String:AnyObject] {
                for value in names.values {
                    if let contact = value["contact"] as? String {
                        self.contacts.append(contact)
                    }
                }
                
            }
            self.tableView.reloadData()
            // print(DataSnapshot)
        }, withCancel: nil)
        
        
        
    }
    
    @objc func addHandler() {
        print("add item")
         let alert = UIAlertController(title: "add", message: "new Contact", preferredStyle: .alert)
        alert.addTextField { (tf) in
            tf.placeholder = "new Contact"
        }
        alert.cancelAction()
        alert.addAction(UIAlertAction(title: "ok", style:.default, handler: { (action) in
            // get text from textfield
            if let text = alert.textFields?.first?.text, !text.isEmpty  {
                        self.uploadContact(contact: text)
            }
            
        }))
         present(alert, animated: true, completion: nil)
        
    }
    func uploadContact(contact:String){
        print(contact)
        
         let childRef = ref.childByAutoId()
        childRef.setValue(["contact":contact])
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contacts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = contacts[indexPath.row]
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
