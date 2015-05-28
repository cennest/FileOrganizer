//
//  UsersNSManagerContext.swift
//  dropFiles
//
//  Created by Kanchan on 07/05/15.
//  Copyright (c) 2015 Cennest. All rights reserved.
//

import Foundation
import CoreData


extension NSManagedObjectContext {
    
    
    func createUser(userName:String, userPassword:String,userFirstName:String, userLastName:String, userEmail:String) -> Users {
        
        var newUser:Users = NSEntityDescription.insertNewObjectForEntityForName(NSManagedObjectContextConstants.kUserEntity, inManagedObjectContext:self) as Users
        var result = newUser.addUserDetail(userName, userPassword: userPassword, userFirstName: userFirstName, userLastName: userLastName, userEmail: userEmail)
        return result
    }
    
    func isUserNameAvailable(userName:String) -> Bool {
        var request = NSFetchRequest(entityName: NSManagedObjectContextConstants.kUserEntity)
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "username = %@",userName)
        var result = self.countForFetchRequest(request, error: nil)
        var flag = false
        if result > 0 {
            flag = true
        }
        return flag;
    }
    
    func isUserRegistered(email:String) -> Bool {
        var flag = false
        var request = NSFetchRequest(entityName: NSManagedObjectContextConstants.kUserEntity)
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "email = %@",email)
        var result = self.countForFetchRequest(request, error: nil)
        if result > 0 {
            flag = true
        }
        return flag
    }
    
    func userLogin(login:String, password:String) -> Bool {
        
        var request = NSFetchRequest(entityName: NSManagedObjectContextConstants.kUserEntity)
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "username = %@",login)
        
        var result:NSArray = self.executeFetchRequest(request, error: nil)!
        for user in result {
            var user = user as Users
            if login == user.username && password == user.password {
                return true
            }
        }
        return false
    }
}