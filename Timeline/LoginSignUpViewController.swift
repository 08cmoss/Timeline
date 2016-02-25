//
//  LoginSignUpViewController.swift
//  Timeline
//
//  Created by Cameron Moss on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class LoginSignUpViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!
    @IBOutlet weak var actionButton: UIButton!
    
    enum ViewMode {
        case Login
        case SignUp
    }
    
    var mode: ViewMode = .SignUp
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViewBasedOnMode()
    }
    
    var fieldsAreValid: Bool {
        get {
            switch mode {
            case .SignUp:
                guard let username = usernameTextField.text, let email = emailTextField.text, let password = passwordTextField.text else {return false}
                return !username.isEmpty && !email.isEmpty && !password.isEmpty
                
            case .Login:
                guard let email = emailTextField.text, let password = passwordTextField.text else {return false}
                return !email.isEmpty && !password.isEmpty
                
            }
        }
    
    }
    
    func updateViewBasedOnMode() {
        switch mode {
        case .SignUp:
            usernameTextField.hidden = false
            emailTextField.hidden = false
            passwordTextField.hidden = false
            bioTextField.hidden = false
            websiteTextField.hidden = false
            actionButton.setTitle("Sign Up", forState: .Normal)
            
        case .Login:
            usernameTextField.hidden = true
            emailTextField.hidden = false
            passwordTextField.hidden = false
            bioTextField.hidden = true
            websiteTextField.hidden = true
            actionButton.setTitle("Login", forState: .Normal)
        }
        
    }
    
    @IBAction func actionButtonTapped(sender: AnyObject) {
        
        if fieldsAreValid {
        switch mode {
        case .SignUp:
            UserController.createUser(emailTextField.text!, username: usernameTextField.text!, password: passwordTextField.text!, bio: bioTextField.text, url: websiteTextField.text, completion: { (success, user) -> Void in
                if success {
                    
                }
            })
            
        case .Login:
            UserController.authenticateUser(emailTextField.text!, password: passwordTextField.text!, completion: { (success, user) -> Void in
                
            })
        
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
