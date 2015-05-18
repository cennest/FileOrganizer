//
//  Constants.swift
//  dropFiles
//
//  Created by Kanchan on 11/05/15.
//  Copyright (c) 2015 Cennest. All rights reserved.
//

import Foundation


struct User {
    var userName:String
    var password:String
    var repeatPassword:String
    var email:String
    var firstName:String
    var lastName:String
    
    init(userName:String, password:String, repeatPassword:String, firstName:String, lastName:String, email:String) {
        self.userName = userName
        self.password = password
        self.repeatPassword = repeatPassword
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
}


struct NSManagedObjectContextConstants {
    static var kUserEntity = "Users"
}

struct UsersConstants {
    static var kSuccessfulSignUpMessage = "Successfully Sign Up..\n\n\n Now, you can proceed for login!!!"
    static var kErrorMessage = "Error"
    static var kSuccessfulSignInMessage = "You have been successfully logged in!!!"
    static var kInvalidUserName = "The user name is not valid"
    static var kInvalidPassword = "The password is not valid"
    static var kInvalidEmailID = "Please enter a valid email ID"
    static var kInvalidFirstName = "The first name is not valid"
    static var kInvalidLastName = "The last name is not valid"
    static var kFailingSignInMessage = "Invalid user id and password"
    static var kUserNameExists = "Username already exists..\n\n\n Please, try some other username!!!"
    static var kEmailIDRegistered = "The email ID is already registered"
    static var kEnterUserName = "Please, enter the user name"
    static var kEnterPassword = "Please, enter a password"
    static var kEnterPasswordAgain = "Please, enter the password again"
    static var kPasswordNotMatch = "Password does not match"
    static var kEnterEmailID = "Please, enter the email ID"
    static var kEnterFirstName = "Please, enter a first name"
    static var kEnterLastName = "Please, enter a last name"
    static var kNameRegex = "^[a-z]{1,10}$"
    static var kPasswordRegex = "[a-z0-9_-]{6,18}"
    static var kUserNameRegex = "[a-z0-9_-]{3,16}"
    static var kEmailIDRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
    static var kPredicateFormat = "SELF MATCHES %@"
}