//
//  AppVC.swift
//  ReportsPPH
//
//  Created by iulian david on 11/29/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import UIKit

/**
 The view that actually does the reports
 */
class AppVC: BaseViewController {

    @IBOutlet weak var wellcomeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        addSlideMenuButton()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
}
