//
//  DataManager.swift
//  dropFiles
//
//  Created by Kanchan on 07/05/15.
//  Copyright (c) 2015 Cennest. All rights reserved.
//

import Foundation
import UIKit
import CoreData


private let _sharedDataAccess = DataManager()

class DataManager:NSObject {
    
    class func sharedDataAccess() -> DataManager {
        return _sharedDataAccess
    }
    
    lazy var context : NSManagedObjectContext? = {
        if let managedContext : NSManagedObjectContext? = self.managedObjectContext {
            return managedContext
        } else {
            return nil
        }
        }()
    
    func createNewUser(userName:String, userPassword:String,userFirstName:String, userLastName:String, userEmail:String) -> Users {
        
        var error:NSError?
        var newUser = context?.createUser(userName, userPassword: userPassword, userFirstName: userFirstName, userLastName: userLastName, userEmail: userEmail)
        context?.save(&error)
        if let err = error {
            NSLog(err.description)
        }
        self.saveContext()
        return newUser!
    }
    
    
    func isUserNameAvailable(userName:String) -> Bool {
        var isUserNameAvailable = context?.isUserNameAvailable(userName)
        return isUserNameAvailable!
    }
    
    func isUserRegistered(email:String) -> Bool {
        var isUserRegister = context?.isUserRegistered(email)
        return isUserRegister!
    }
    
    func userLogin(login:String, password:String) -> Bool {
        var isLoginSuccess = context?.userLogin(login, password: password)
        return isLoginSuccess!
    }
    
    func createFile(title:String, fileID:Int, size:String, location:String, createdDate:String , modifiedDate:String , category: Category, isDownloaded:Bool, userID:Int) -> Files {
        var error:NSError?
        var newUser = context?.createNewFile(title, fileID: fileID, size: size, location: location, createdDate: createdDate, modifiedDate: modifiedDate, category: category, isDownloaded: isDownloaded, userID: userID)
        context?.save(&error)
        if let err = error {
            NSLog(err.description)
        }
        self.saveContext()
        return newUser!
    }
    
    func downloadFile() {
        
    }
    
    func getFileList() -> [Files] {
        var fileList = context?.getFileList()
        return fileList!
        
    }
    
    func getFileListForCategory(category:Category) -> [Files] {
        var fileList = context?.getFileListForCategory(category)
        return fileList!
    }
    
    
    func deleteFile() {
        
    }
    
    
    //Core Data
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "Cennest.dropFiles" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] as NSURL
        }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("dropFiles", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
        }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("dropFiles.sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        let migrationOptions = [NSMigratePersistentStoresAutomaticallyOption: true,
            NSInferMappingModelAutomaticallyOption: true]
        if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: migrationOptions, error: &error) == nil {
            coordinator = nil
            // Report any error we got.
            let dict = NSMutableDictionary()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        }
        return coordinator
        }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
        }()
    
    
    func saveContext () {  //call  self.saveContext()
        let context:NSManagedObjectContext = self.managedObjectContext!
        if context.hasChanges {
            
            context.performBlockAndWait{
                var saveError:NSError?
                let saved = context.save(&saveError)
                
                if !saved {
                    if let error = saveError{
                        NSLog("Warning!! Saving error \(error.description)")
                    }
                }
            }
        }
    }
}