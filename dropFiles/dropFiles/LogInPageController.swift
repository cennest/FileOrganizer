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
    
    @IBOutlet weak var loginView: UIView!
    let alertController:AlertController = AlertController()
    
    
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
    
    @IBAction func handleForgotPasswordTap(sender: AnyObject) {
      
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
        var result = dataManager.userLogin(userName,password:password)
        
        if result {
            alertController.showMessage(UsersConstants.kSuccessfulSignInMessage, controller: self)
            
            var storyboard:UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
            var vc:UIViewController = storyboard.instantiateViewControllerWithIdentifier("fileViewController") as FileOraganizerViewController
            self.presentViewController(vc, animated:true, completion:nil)
        } else {
            alertController.showMessage(UsersConstants.kFailingSignInMessage, controller: self)
        }
    }
    
    func checkCredential(userName:String, password:String)  -> Bool {
        if userName.isEmpty {
            alertController.showMessage(UsersConstants.kEnterUserName, controller: self)
            return false
        }
        if password.isEmpty {
            alertController.showMessage(UsersConstants.kEnterPassword, controller: self)
            return false
        }
        return true
    }
}
