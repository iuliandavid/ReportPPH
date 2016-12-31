//
//  LoginVC.swift
//  ReportsPPH
//
//  Created by iulian david on 11/29/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import UIKit

/**
 Login logic
 */
class LoginVC: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    var activeTextField : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForNotifications()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func login(_ sender: UIButton) {

        SwiftSpinner.show("Logging In")
        var authenticationSuccess = false
        var myerr:MyError = MyError.UnhandledError("Unknown error")
        
        networking.executeAccessTokenRequest(username: usernameTxt.text!, password: passwordTxt.text!) {
            (result) in
            switch (result) {
            case .Success(let accessToken) :
                self.dataService.user?.tokenInfo = accessToken as? TokenInfo
                self.dataService.saveUserData()
                authenticationSuccess = true
                break;
                
            case .Failure(let err):
                myerr = err
                break;
            }
            SwiftSpinner.hide()
            if (authenticationSuccess == true) {
                self.dismiss(animated: true, completion: nil)
            } else {
                switch (myerr) {
                case .AuthenticationFailure :
                    self.showAlert(withTitle: "Authentication Failure", message: myerr.value)
                    break
                case .UnhandledError :
                    self.showAlert(withTitle: "Unhandled Error", message: myerr.value)
                    break
                case .NetworkError :
                    self.showAlert(withTitle: "Error", message: myerr.value)
                    break
                }
                
            }
            
        }
        
        
    }
    
    
    func keyboardWillShow(_ notification:NSNotification?) {
        guard (activeTextField) != nil else {
            return
        }
        let keyboardSize = (notification?.userInfo![UIKeyboardFrameBeginUserInfoKey]! as AnyObject).cgRectValue.size
        self.view.frame.origin.y = 0
        let keyboardYPosition = self.view.frame.size.height - keyboardSize.height
        if keyboardYPosition < activeTextField!.frame.origin.y {
            UIView.animate(withDuration: Config.AnimationTimes.SHORT.rawValue) { () -> Void in
                self.view.frame.origin.y = self.view.frame.origin.y - keyboardSize.height + 30
            }
        }
    }
    
    func keyboardWillHide(_ notification:NSNotification?) {
        UIView.animate(withDuration: Config.AnimationTimes.SHORT.rawValue) { () -> Void in
            self.view.frame.origin.y = 0
        }
    }
   
    private func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(LoginVC.keyboardWillShow(_:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(LoginVC.keyboardWillHide(_:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
    }
   
    func showAlert(withTitle title:String, message:String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title,
                                          message: message, preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Dismiss", style: .destructive, handler: nil)
            alert.addAction(dismissAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}


extension LoginVC: UITextFieldDelegate, DataServiceInjected, NetworkingApiInjected {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
    }
}


