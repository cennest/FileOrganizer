//
//  dropFiles.swift
//  dropFiles
//
//  Created by Kanchan on 05/05/15.
//  Copyright (c) 2015 Cennest. All rights reserved.
//

import Foundation
import CoreData

class Users: NSManagedObject {
    
    @NSManaged var email: String
    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var password: String
    @NSManaged var userid: NSNumber
    @NSManaged var username: String
    
}

