//
// Created by iulian david on 12/26/16.
// Copyright (c) 2016 iulian david. All rights reserved.
//

import Foundation

typealias TestLoginCompleted = (Bool) -> ()


protocol DataService {

    /**
     Retrieve the user property
    */
    var user:UserAuth? {
            get
            set
        }
    
    func testLogin(completed: @escaping TestLoginCompleted)

    func saveUserData()

    func loadUserData()
}
