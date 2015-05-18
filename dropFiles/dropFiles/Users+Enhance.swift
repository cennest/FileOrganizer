//
//  UsersEnhance.swift
//  dropFiles
//
//  Created by Kanchan on 07/05/15.
//  Copyright (c) 2015 Cennest. All rights reserved.
//

import Foundation
import CoreData

extension Users {
    
    func createNewUser(userName:String, userPassword:String,userFirstName:String, userLastName:String, userEmail:String) -> Users {
        
        self.userid = 1
        self.username = userName
        self.password = userPassword
        self.email = userEmail
        self.firstName = userFirstName
        self.lastName = userLastName
        
        return self
    }
    
    
    
}