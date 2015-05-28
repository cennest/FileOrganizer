//
//  LogInPageController.swift
//  dropFiles
//
//  Created by Kanchan on 29/04/15.
//  Copyright (c) 2015 Cennest. All rights reserved.
//


import Foundation
import UIKit
import CoreData


class LoginPageController: UIViewController {
    
    
    @IBOutlet weak var logInTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var userNameErrorLabel: UILabel!
    @IBOutlet weak var loginView: UIView!
    var isCredintialValid:Bool = true
    
    override func viewDidAppear(animated: Bool) {
        var ovalRect = CGRect(x:-5,y:-5 ,width: 310 ,height: 310)
        var shadowPath:UIBezierPath = UIBezierPath(roundedRect:ovalRect, cornerRadius: 1)
        var layer = loginView.layer
        println(loginView.frame)
        layer.shadowPath = shadowPath.CGPath
        layer.shadowColor = UIColor.orangeColor().CGColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    @IBAction func handleSignInTap(sender: AnyObject) {
        let userName = logInTextField.text
        let password = passwordTextField.text
        
        if self.checkCredential(userName, password:password) {
            //verify userlogin and Password
            self.verifyUser(userName,password:password)
            //sussess Alert view
        }
    }
    
    func verifyUser(userName:String, password:String) {
        var dataManager = DataManager.sharedDataAccess()
        var isValidUser = dataManager.userLogin(userName,password:password)
        
        if isValidUser {
            self.onSuccessfulLogin()
        } else {
            self.onLoginFailure()
        }
    }
    
    func onLoginFailure() {
        let alertController:UIAlertController = UIAlertController(title: UsersConstants.kFailingSignInTitle , message: UsersConstants.kFailingSignInMessage, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: CommonConstants.kOk, style: UIAlertActionStyle.Default, handler:nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func onSuccessfulLogin() {
        let alertController = UIAlertController(title: UsersConstants.kSuccessfulSignInTitle, message: UsersConstants.kSuccessfulSignInMessage, preferredStyle: .Alert)
        var okAction = UIAlertAction(title: CommonConstants.kOk, style: UIAlertActionStyle.Default) {
            UIAlertAction in
            self.handleOk()
        }
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func handleOk() {
        var storyboard:UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
        let vc : AnyObject! = storyboard.instantiateViewControllerWithIdentifier(FileOraganizerViewControllerConstants.kStoryboardIdentifier)  as UIViewController
        self.presentViewController(vc as FileOraganizerViewController, animated: true, completion: nil)
    }
    
    func checkCredential(userName:String, password:String)  -> Bool {
        isCredintialValid = true
        self.validateUserName(userName)
        self.validatePassword(password)
        if isCredintialValid == true {
            return true
        } else {
            return false
        }
    }
    
    func validateUserName(userName:String)-> Bool {
        var message:String?
        if userName.isEmpty {
            userNameErrorLabel.hidden = false
            userNameErrorLabel.text = UsersConstants.kEnterUserName
            isCredintialValid = false
            return false
        } else {
            userNameErrorLabel.hidden = true
            return true
        }
    }
    
    func validatePassword(userName:String)-> Bool {
        var message:String?
        if userName.isEmpty {
            passwordErrorLabel.hidden = false
            passwordErrorLabel.text = UsersConstants.kEnterPassword
            isCredintialValid = false
            return false
        } else {
            passwordErrorLabel.hidden = true
            return true
        }
    }
    
    
}
