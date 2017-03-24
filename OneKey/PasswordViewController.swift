//
//  PasswordViewController.swift
//  OneKey
//
//  Created by Tirumalasetty, Akhil on 2/9/17.
//  Copyright © 2017 Tirumalasetty, Akhil. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

class PasswordViewController: UITableViewController {

    var list :[ModelObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
               let nc = NotificationCenter.default
        nc.addObserver(forName:myNotification, object:nil, queue:nil, using:catchNotification)
        self.perform(#selector(PasswordViewController.getUserDetails), with:nil, afterDelay: 0.05)
    }
    
    func getUserDetails(){
        
        let getList = UserDetails()
        list =  getList.getDetails()
        tableView.reloadData()
    }
   // MARK:- Notification for reload table view
    func catchNotification(notification:Notification) -> Void {
        
        let message  = notification.userInfo?["message"] as? String
        let tempObj = notification.object!

        
        if message == "add"{
            list.append(tempObj as! ModelObject)
            tableView.reloadData()
        }
            
        else{
           
            for obj:ModelObject in list{
                
                if obj.id == (tempObj as! ModelObject).id{
                    
                    //print("i value in loop",obj.userName)
                    list[list.index(of:obj)!] = tempObj as! ModelObject
                }
            }
          tableView.reloadData()
        }
       
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "row", for: indexPath)
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor=UIColor.red
        }
        else{
            cell.backgroundColor=UIColor.yellow
        }
        
        let eachRow = list[indexPath.row]
        
        let image1  = cell.viewWithTag(10) as! UIImageView
        let image2  = cell.viewWithTag(20) as! UIImageView
        let image3  = cell.viewWithTag(30) as! UIImageView
        
        
        let label1  = cell.viewWithTag(40) as! UILabel
        let label2  = cell.viewWithTag(50) as! UILabel
        let label3  = cell.viewWithTag(60) as! UILabel
        
        let username:String = (eachRow.value(forKey:"userName")as? String)!
        let emailid:String = (eachRow.value(forKey:"emailId")as? String)!
        
        
        if username.characters.count>0 && emailid.characters.count>0{
        
            image3.isHidden = false
            label3.isHidden = false
            label1.text = username
            label2.text = emailid
            label3.text = eachRow.value(forKey:"password")as? String
        }
        else{
            image3.isHidden = true
            label3.isHidden = true
            if username.characters.count>0{
                label1.text = username
            }
            else{
                label1.text = emailid
            }
            label2.text = eachRow.value(forKey:"password")as? String
        }
        
        return cell
    }
 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        let eachRow = list[indexPath.row]
        let username:String = (eachRow.value(forKey:"userName")as? String)!
        let emailid:String = (eachRow.value(forKey:"emailId")as? String)!
        if username.characters.count>0 && emailid.characters.count>0{
            return 101.0
        }
        else{
            return 70.0
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let userObject  = list[indexPath.row]
        
        let addDetails = self.storyboard?.instantiateViewController(withIdentifier:"AddDetailsViewControllerSID") as? AddDetailsViewController
        addDetails?.userObj = userObject
        self.navigationController?.pushViewController(addDetails!, animated: true)
        
    }
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let userId  = list[indexPath.row].id
            let udetails = UserDetails()
            udetails.deleteDetails(userId:Int32(userId))
             list.remove(at: indexPath.row)
             tableView.reloadData()
         }
 
        }

    @IBAction func logoutButton(_ sender: Any) {
        
        let nc = NotificationCenter.default
        nc.post(name:myLoginNotification,
                object: nil,
                userInfo:nil)

        _ = navigationController?.popViewController(animated: true)
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
