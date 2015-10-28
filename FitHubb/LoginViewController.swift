//
//  LoginViewController.swift
//  FitHubb
//
//  Created by Steven Huynh on 10/27/15.
//  Copyright © 2015 Steven Huynh. All rights reserved.
//

import UIKit
class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        ConfirmPasswordInputField.hidden = true
        RegisterButton.hidden = true
        Error.hidden = true
        PasswordError.hidden = true
    }
    @IBOutlet weak var UserNameInputField: UITextField!
    @IBOutlet weak var PasswordInputField: UITextField!
    @IBOutlet weak var ConfirmPasswordInputField: UITextField!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var RegisterButton: UIButton!
    @IBOutlet weak var Error: UILabel!
    @IBOutlet weak var PasswordError: UILabel!
    @IBAction func LoginButtonPressed(sender: UIButton) {
        if UserNameInputField.text! != "" && PasswordInputField.text! != "" {
            if let urlToReq = NSURL(string: "https://lifthubb.herokuapp.com/") {
                let request = NSMutableURLRequest(URL: urlToReq)
                request.HTTPMethod = "POST"
                let bodyData = "UserName=\(UserNameInputField.text!) & Password=\(PasswordInputField.text!)"
                request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding)
                NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: afterRequest).resume()
            }
        }
        else {
            Error.hidden = false
        }
    }
    @IBAction func RegisterButtonPressed(sender: UIButton) {
//        if PasswordInputField.text! == ConfirmPasswordInputField.text! {
            if let urlToReq = NSURL(string: "https://lifthubb.herokuapp.com/events") {
                let request = NSMutableURLRequest(URL: urlToReq)
                request.HTTPMethod = "POST"
                let bodyData = "Email=\(UserNameInputField.text!)"
                request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding)
                NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: afterRequest).resume()
//            }
        }
        else {
            PasswordError.hidden = false
        }
    }

    @IBAction func SignUpButtonPressed(sender: UIButton) {
        ConfirmPasswordInputField.hidden = false
        RegisterButton.hidden = false
        SignUpButton.hidden = true
    }
    func afterRequest(data: NSData?, response: NSURLResponse?, error: NSError?) {
        
    }



    
}