//
//  SignUp.swift
//  DropFile
//
//  Created by Kanchan on 17/04/15.
//  Copyright (c) 2015 Cennest. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class SignUpPageController: UIViewController {
    
    
    var isCredintialValid:Bool = true
    let loginController:LoginPageController = LoginPageController()
    var dataManager = DataManager.sharedDataAccess()
    
    
    @IBOutlet weak var userNameErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var repeatePasswordErrorLabel: UILabel!
    @IBOutlet weak var firstNameErrorLabel: UILabel!
    @IBOutlet weak var lastNameErrorLabel: UILabel!
    @IBOutlet weak var emailErrorLabel: UILabel!
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func handleSignUp(sender: AnyObject) {
        var user:User = User(userName: userNameTextField.text, password: passwordTextField.text, repeatPassword: repeatPasswordTextField.text, firstName: firstNameTextField.text, lastName: lastNameTextField.text, email: emailTextField.text)
        
        //chk empty field
        var isValidCredential =  self.checkCredential(user)
        //store data
        if isValidCredential {
            var isDataStore = self.storeRegisterData(user)
            if isDataStore {
                self.clearTextField()
                self.onSuccessfulSignUp()
                userNameTextField.becomeFirstResponder()
            } else {
                self.onSignUpFailure()
            }
        }
    }
    
    func onSignUpFailure() {
        let alertController:UIAlertController = UIAlertController(title: UsersConstants.kFailureSignUpTitle, message: UsersConstants.kFailureSignUpMessge , preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: CommonConstants.kOk, style: UIAlertActionStyle.Default, handler:nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func onSuccessfulSignUp() {
        let alertController:UIAlertController = UIAlertController(title: UsersConstants.kSuccessfulSignUpTitle , message: UsersConstants.kSuccessfulSignUpMessage, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title:CommonConstants.kOk, style: UIAlertActionStyle.Default, handler:nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func handleSignInPage(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        self.presentViewController(loginController, animated: true, completion: nil)
    }
    
    func clearTextField() {
        userNameTextField.text = ""
        passwordTextField.text = ""
        firstNameTextField.text = ""
        lastNameTextField.text = ""
        emailTextField.text = ""
        repeatPasswordTextField.text = ""
    }
    
    func storeRegisterData(user:User) -> Bool {
        
        var newUser = dataManager.createNewUser(user.userName, userPassword:user.password, userFirstName: user.firstName, userLastName: user.lastName, userEmail: user.email)
        println(newUser.description)
        return true
    }
    
    
    func isUserNameAvailable(userName:String) -> Bool {
        var flag = false
        var isUserAvail:Bool = dataManager.isUserNameAvailable(userName)
        if isUserAvail {
            userNameTextField.text = ""
            userNameTextField.becomeFirstResponder()
            flag = true
        }
        return flag
    }
    
    func isEmailIDRegister(email:String) -> Bool {
        var flag = false
        var isUserRegister:Bool = dataManager.isUserRegistered(email)
        if isUserRegister {
            emailTextField.text = ""
            emailTextField.becomeFirstResponder()
            flag = true
        }
        return flag
    }
    
    func checkCredential(user:User)  -> Bool {
        isCredintialValid = true
        self.validateLastName(user.lastName)
        self.validateFirstName(user.firstName)
        self.validateEmailId(user.email)
        self.validatePassword(user.password, repeatePassword:user.repeatPassword)
        self.validateUserName(user.userName)
        
        if isCredintialValid == true {
            return true
        } else {
            return false
        }
    }
    
    
    func validateFirstName(firstName:String) {
        var message:String?
        if firstName.isEmpty {
            message = UsersConstants.kEnterFirstName
        } else if !validateName(firstName) {
            message = UsersConstants.kInvalidFirstName
        }
        if (message != nil) {
            firstNameErrorLabel.hidden = false
            firstNameErrorLabel.text = message
            isCredintialValid = false
        } else {
            firstNameErrorLabel.hidden = true
        }
    }
    
    func validateLastName(lastName:String) {
        var message:String?
        if lastName.isEmpty {
            message = UsersConstants.kEnterLastName
        } else if !validateName(lastName) {
            message = UsersConstants.kInvalidLastName
        }
        if (message != nil) {
            lastNameErrorLabel.hidden = false
            lastNameErrorLabel.text = message
            isCredintialValid = false
        } else {
            lastNameErrorLabel.hidden = true
        }
    }
    
    func validateName(name:String) -> Bool {
        let nameRegex = UsersConstants.kNameRegex
        return NSPredicate(format: UsersConstants.kPredicateFormat ,nameRegex)!.evaluateWithObject(name)
    }
    
    func validateEmailId(email:String) {
        var message:String?
        let emailRegex = UsersConstants.kEmailIDRegex
        var isValidFormat = NSPredicate(format: UsersConstants.kPredicateFormat , emailRegex)!.evaluateWithObject(email)
        if email.isEmpty {
            message = UsersConstants.kEnterEmailID
        } else if !isValidFormat {
            message = UsersConstants.kInvalidEmailID
        } else if isEmailIDRegister(email) {
            message = UsersConstants.kEmailIDRegistered
        }
        
        if (message != nil) {
            emailErrorLabel.hidden = false
            emailErrorLabel.text = message
            isCredintialValid = false
        } else {
            emailErrorLabel.hidden = true
        }
    }
    
    func validateUserName(userName:String) {
        var message:String?
        let userNameRegex = UsersConstants.kUserNameRegex
        var isValidFormat = NSPredicate(format: UsersConstants.kPredicateFormat , userNameRegex)!.evaluateWithObject(userName)
        if userName.isEmpty {
            message = UsersConstants.kEnterUserName
        } else if !isValidFormat {
            message = UsersConstants.kInvalidUserName
        } else if isUserNameAvailable(userName) {
            message = UsersConstants.kUserNameExists
        }
        if (message != nil) {
            userNameErrorLabel.hidden = false
            userNameErrorLabel.text = message
            isCredintialValid = false
        } else {
            userNameErrorLabel.hidden = true
        }
    }
    
    func validatePassword(password:String, repeatePassword:String) {
        var message:String?
        let passwordRegex = UsersConstants.kPasswordRegex
        var isValidFormat = NSPredicate(format: UsersConstants.kPredicateFormat , passwordRegex)!.evaluateWithObject(password)
        
        if password.isEmpty {
            message = UsersConstants.kEnterPassword
        } else if !isValidFormat {
            message = UsersConstants.kInvalidPassword
        }
        if (message != nil) {
            passwordErrorLabel.hidden = false
            passwordErrorLabel.text = message
        }
        if repeatePassword.isEmpty {
            message = UsersConstants.kEnterPasswordAgain
            repeatePasswordErrorLabel.hidden = false
            repeatePasswordErrorLabel.text = message
        } else if  password != repeatePassword {
            message = UsersConstants.kPasswordNotMatch
            passwordErrorLabel.hidden = false
            passwordErrorLabel.text = message
            
            repeatePasswordErrorLabel.hidden = false
            repeatePasswordErrorLabel.text = message
        }
        
        if (message != nil) {
            isCredintialValid = false
        } else {
            passwordErrorLabel.hidden = true
            repeatePasswordErrorLabel.hidden = true
        }
        
    }
    
}


