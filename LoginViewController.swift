//
//  LoginViewController.swift
//  OneKey
//
//  Created by Tirumalasetty, Akhil on 2/13/17.
//  Copyright © 2017 Tirumalasetty, Akhil. All rights reserved.
//

import UIKit
import LocalAuthentication
import UserNotifications

class LoginViewController: UIViewController {

 
    override func viewDidLoad() {
        super.viewDidLoad()
         authenticateUser()
        
        let nc = NotificationCenter.default
        nc.addObserver(forName:myLoginNotification, object:nil, queue:nil, using:catchLoginNotification)
        
    }
    
    func catchLoginNotification(notification:Notification) -> Void {
        
        authenticateUser()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
  
    }
    func authenticateUser() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [unowned self] success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        //self.runSecretCode()
                        print("successfulyy login")
                        let showDetails = self.storyboard?.instantiateViewController(withIdentifier:"PasswordViewControllerSID") as? PasswordViewController
                        
                        self.navigationController?.pushViewController(showDetails!, animated: true)
                        
                        
                    } else {
                        let ac = UIAlertController(title: "Authentication failed", message: "Sorry!", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(ac, animated: true)
                    }
                }
            }
        } else {
            let ac = UIAlertController(title: "Touch ID not available", message: "Your device is not configured for Touch ID.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }

    

}
