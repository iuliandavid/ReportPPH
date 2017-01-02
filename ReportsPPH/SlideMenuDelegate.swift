//
//  SlideMenuDelegate.swift
//  ReportsPPH
//
//  Created by iulian david on 1/1/17.
//  Copyright © 2017 iulian david. All rights reserved.
//

import Foundation

/**
 Protocol that define the method to use on clicking the row in the table shown in the slide menu
 */
protocol SlideMenuDelegate {
    func slideMenuItemSelected(atIndex : Int)
}
