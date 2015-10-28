//
//  LoginViewController.swift
//  FitHubb
//
//  Created by Steven Huynh on 10/27/15.
//  Copyright © 2015 Steven Huynh. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
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
//
//            if let urlToReq = NSURL(string: "https://fithubb.herokuapp.com/api/events/8") {
//                let request = NSMutableURLRequest(URL: urlToReq)
//                request.HTTPMethod = "PUT"
//                let bodyData = "event[title]=\(UserNameInputField.text!)"
//                request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding)
//                NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: afterRequest).resume()
//            }

        if PasswordInputField.text! == ConfirmPasswordInputField.text! {
            Alamofire.request(.PUT, "https://fithubb.herokuapp.com/api/events/8", parameters: ["event[title]":UserNameInputField.text!])
                .responseJSON { response in
    //                print(response.request)  // original URL request
    //                print(response.response) // URL response
    //                print(response.data)     // server data
    //                print(response.result)   // result of response serialization
                    
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                    }
            }
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
        let json = JSON(data: data!)
        print(json)

    }



    
}