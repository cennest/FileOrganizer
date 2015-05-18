//
//  Files.swift
//  dropFiles
//
//  Created by Kanchan on 12/05/15.
//  Copyright (c) 2015 Cennest. All rights reserved.
//

import Foundation
import CoreData

class Files: NSManagedObject {

    @NSManaged var title: String
    @NSManaged var fileID: NSNumber
    @NSManaged var size: String
    @NSManaged var location: String
    @NSManaged var createdDate: String
    @NSManaged var modifiedDate: String
    @NSManaged var categoryID: NSNumber
    @NSManaged var isDownloaded: NSNumber
    @NSManaged var userID: NSNumber

}
