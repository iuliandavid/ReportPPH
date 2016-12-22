//
//  ViewController.swift
//  ReportsPPH
//
//  Created by iulian david on 11/26/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        SwiftSpinner.show("Initial Data")
        DataService.instance.testLogin{
            
            if(DataService.instance.isUserLoggedIn){
                self.loadMainView()
            }
                
            else{
                self.loadLoginView()
            }
            SwiftSpinner.hide()
        }
        
        
    }
    func loadMainView() {
        if let appVC = UIStoryboard(name: "App", bundle: nil).instantiateViewController(withIdentifier: "App") as? AppVC {
            self.present(appVC, animated: true, completion: nil)
        }
    }
    
    
    func loadLoginView(){
        if let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "Login") as? LoginVC {
            self.present(loginVC, animated: true, completion: nil)
        }
    }
    

}

