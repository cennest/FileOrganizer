//
//  AlertController.swift
//  dropFiles
//
//  Created by Kanchan on 05/05/15.
//  Copyright (c) 2015 Cennest. All rights reserved.
//

import Foundation
import UIKit

class AlertController: UIViewController {

    func showMessage(alertMessage:String, controller:UIViewController) {
        let alert = UIAlertController(title: nil , message: alertMessage, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        controller.presentViewController(alert, animated: true, completion: nil)
    }
}