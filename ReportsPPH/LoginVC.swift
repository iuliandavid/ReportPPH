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

        SwiftSpinner.show("Loggin In")
        var authenticationSuccess = false
        
        ApiClient.instance.executeAccessTokenRequest(username: usernameTxt.text!, password: passwordTxt.text!, withDataService: dataService) {
            (accessTokenReceived) in
            authenticationSuccess = accessTokenReceived
            SwiftSpinner.hide()
            if (authenticationSuccess == true) {
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        
        
    }
    
    
    func keyboardWillShow(_ notification:NSNotification?) {
        let keyboardSize = (notification?.userInfo![UIKeyboardFrameBeginUserInfoKey]! as AnyObject).cgRectValue.size
        self.view.frame.origin.y = 0
 //       let keyboardYPosition = self.view.frame.size.height - keyboardSize.height
//        if keyboardYPosition < self.activeTextField!.frame.origin.y {
//            UIView.animate(withDuration: Config.AnimationTimes.SHORT.rawValue) { () -> Void in
//                self.view.frame.origin.y = self.view.frame.origin.y - keyboardSize.height + 30
//            }
//        }
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
    
}


extension LoginVC: UITextFieldDelegate,DataServiceInjected {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
    }
}


