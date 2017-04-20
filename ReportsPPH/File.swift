//
//  File.swift
//  ReportsPPH
//
//  Created by iulian david on 4/20/17.
//  Copyright © 2017 iulian david. All rights reserved.
//

import UIKit

extension UITextField {
    var autocorrectionType: UITextAutocorrectionType {
        get {
            if ProcessInfo.processInfo.environment["AutoCorrection"] == "Disabled" {
                return UITextAutocorrectionType.no
            } else {
                return super.autocorrectionType
            }
        }
        set {
            super.autocorrectionType = newValue
        }
    }
}
