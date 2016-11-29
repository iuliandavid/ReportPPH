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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func login(_ sender: UIButton) {

        DataService.instance.isUserLoggedIn = true
        self.dismiss(animated: true, completion: nil)
    }
   
}
