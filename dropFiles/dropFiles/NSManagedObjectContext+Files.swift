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
    
    func createNewFile(title:String, fileID:Int, size:String, location:String, createdDate:String , modifiedDate:String , category: Category, isDownloaded:Bool, userID:Int) -> Files {
        
        var newData:Files = NSEntityDescription.insertNewObjectForEntityForName(NSManagedObjectContextConstants.kFileEntity , inManagedObjectContext:self) as Files
        var result = newData.addFileDetail(title, fileID: fileID, size: size, location: location, createdDate: createdDate, modifiedDate: modifiedDate, category: category, isDownloaded: isDownloaded, userID: userID)
        return result
    }
    
    func getFileList() -> [Files] { //fetch req in try catch block
        var files  = [Files]()
        var fetchRequest = NSFetchRequest(entityName: NSManagedObjectContextConstants.kFileEntity)
        files = self.executeFetchRequest(fetchRequest, error: nil) as [Files]
        return files
    }
    
    func getFileListForCategory(category:Category) -> [Files]  {
        var files  = [Files]()
        var fetchRequest = NSFetchRequest(entityName: NSManagedObjectContextConstants.kFileEntity)
        var resultPredicate = NSPredicate(format: "category == %d", category.rawValue)
        fetchRequest.predicate = resultPredicate
        files = self.executeFetchRequest(fetchRequest, error: nil) as [Files]
        return files
    }
}