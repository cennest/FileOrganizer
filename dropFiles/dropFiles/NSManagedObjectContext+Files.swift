//
//  NSManagedObjectContext+Files.swift
//  dropFiles
//
//  Created by Kanchan on 12/05/15.
//  Copyright (c) 2015 Cennest. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    
    func insertData(title:String, fileID:NSNumber, size:String, location:String, createdDate:String , modifiedDate:String , categoryID: NSNumber, isDownloaded:Bool, userID:NSNumber) -> Files {
        
        var newData:Files = NSEntityDescription.insertNewObjectForEntityForName(NSManagedObjectContextConstants.kFileEntity , inManagedObjectContext:self) as Files
        var result = newData.insertNewFile(title, fileID: fileID, size: size, location: location, createdDate: createdDate, modifiedDate: modifiedDate, categoryID: categoryID, isDownloaded: isDownloaded, userID: userID)
        return result
    }
}