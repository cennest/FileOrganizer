//
//  OpenLibraryViewController.swift
//  dropFiles
//
//  Created by Kanchan on 26/05/15.
//  Copyright (c) 2015 Cennest. All rights reserved.
//


import UIKit
import Foundation

protocol GetSelectedFile {
    func selectedFile(fileData:NSData, fileName:NSString)
}



class OpenLibrary: UIViewController, UIImagePickerControllerDelegate,UIPopoverControllerDelegate , UIAlertViewDelegate,  UINavigationControllerDelegate {
    
    var picker:UIImagePickerController? = UIImagePickerController()
    var popover:UIPopoverController?=nil
    var delegate: GetSelectedFile?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var btnClickMe: UIButton!
    
    
    convenience override init() {
        self.init(nibName:"OpenLibraryViewController",bundle:nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker?.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func openGallary()
    {
        picker!.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad
        {
            self.presentViewController(picker!, animated: true, completion: nil)
        }
        else
        {
            popover = UIPopoverController(contentViewController: picker!)
            popover!.presentPopoverFromRect(btnClickMe.frame, inView: self.view, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
        }
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera))
        {
            picker!.sourceType = UIImagePickerControllerSourceType.Camera
            self .presentViewController(picker!, animated: true, completion: nil)
        }
        else
        {
            openGallary()
        }
    }
    
    
    @IBAction func browseData(sender: AnyObject) {
        var alert:UIAlertController = UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        var cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default)
            {
                UIAlertAction in
                self.openCamera()
                
        }
        var gallaryAction = UIAlertAction(title: "Gallary", style: UIAlertActionStyle.Default)
            {
                UIAlertAction in
                self.openGallary()
        }
        var cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel)
            {
                UIAlertAction in
                
        }
        // Add the actions
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        // Present the actionsheet
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone
        {
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else
        {
            popover = UIPopoverController(contentViewController: alert)
            popover!.presentPopoverFromRect(btnClickMe.frame, inView: self.view, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
        }
    }
    
    @IBAction func onBackButtonClick(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: NSDictionary!) {
        var data:NSData?
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .ScaleAspectFit
            imageView.image = pickedImage
            data = UIImagePNGRepresentation(pickedImage);
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
        self.onFileSelection(data!)
    }
    
    func onFileSelection(data:NSData) {
        self.addImageTitle(data)
    }
    
    func addImageTitle(fileData:NSData) {
        var alertController = UIAlertController(
            title: "Title",
            message: "Please enter the Image name",
            preferredStyle: UIAlertControllerStyle.Alert)
        
        var okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
                (action) -> Void in
            var textField:UITextField = alertController.textFields?.first as UITextField
            var title = textField.text
            if title != nil {
            self.handleOk(fileData, fileName: title)
            }
        }
        
        alertController.addTextFieldWithConfigurationHandler {
            (txtEmail) -> Void in
            txtEmail.placeholder = "Enter Image Name"
        }
        
        alertController.addAction(okAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func handleOk(fileData:NSData, fileName:NSString) {
        delegate?.selectedFile(fileData, fileName:fileName)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController!) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}

