//
//  FileOraganizerViewController.swift
//  dropFiles
//
//  Created by Kanchan on 18/05/15.
//  Copyright (c) 2015 Cennest. All rights reserved.
//

import Foundation
import UIKit

class FileOraganizerViewController : UIViewController , UITableViewDelegate, UITableViewDataSource , CloudStorageClientDelegate, GetSelectedFile {
    var credential:AuthenticationCredential = AuthenticationCredential()
    var client:CloudStorageClient = CloudStorageClient()
    var container:NSArray = NSArray()
    var blobArray:NSArray = NSArray()
    
    var fileList = [Files]()
    var dataManager = DataManager.sharedDataAccess()
    var storageService:StorageService = StorageService()
    var selectedCategory:Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        selectedCategory = .Folder
        var client:CloudStorageClient = storageService.setContainer()
        client.delegate = self
        storageService.getBlobContainer()
        self.getFileList()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var sideBarView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func onDeleteTap(sender: AnyObject) {
        //delete file from db
        //refresh db
        var image:UIImage = UIImage(named:"image.png")!
        var data:NSData = UIImagePNGRepresentation(image);
        self.deleteStoreData(data)
        //
    }
    
    @IBAction func onDownloadTap(sender: AnyObject) {
        
        //add location in db
    }
    
    @IBAction func onUploadTap(sender: AnyObject) {
         var broeseData = OpenLibrary()
         broeseData.delegate = self
        self.presentViewController(broeseData, animated: true, completion: nil)
              //add cell in table view÷
    }
  
  func selectedFile(fileData:NSData, fileName:NSString) {
    let formatter = NSByteCountFormatter()
    
    formatter.allowedUnits = NSByteCountFormatterUnits.UseBytes
    formatter.countStyle = NSByteCountFormatterCountStyle.File
    var date = self.convertDateInString()
    let formatted = formatter.stringFromByteCount(Int64(fileData.length))
        var location = self.storeData(fileData, fileName: fileName)
    var res = dataManager.createFile(fileName, fileID: 0, size:formatted, location: location, createdDate:date , modifiedDate:date, category: selectedCategory!, isDownloaded: false, userID: 1)
  }
  
    func convertDateInString() -> NSString {
        let date = NSDate()
        let dateFormatter = NSDateFormatter()
        var theDateFormat = NSDateFormatterStyle.ShortStyle
        let theTimeFormat = NSDateFormatterStyle.ShortStyle
        dateFormatter.dateStyle = theDateFormat
        dateFormatter.timeStyle = theTimeFormat
        return dateFormatter.stringFromDate(date)
    }
  
  
    @IBAction func onCreateNewFolderTap(sender: AnyObject) {
        selectedCategory = .Folder
        //check selected folder path
        //add folder and update path if required
        //show dialog as pop up to give name of the folder or make it accessible to change name as normal
        //OPT: check if folder name already avail
    }
    
    @IBAction func onLogoutTap(sender: AnyObject) {
        // logout
    }
    
    @IBAction func onDocumentsTap(sender: AnyObject) {
        selectedCategory = .Document
        self.fileList = self.getFileListForCategory(selectedCategory!)
        tableView.reloadData()
        //fetch data from db
        //load data on table view
        //observe if ant file selected
    }
    @IBAction func onAllFolderTap(sender: AnyObject) {
        selectedCategory = .Folder
         self.fileList = self.getFileListForCategory(selectedCategory!)
        tableView.reloadData()
        //fetch path and load data that are contain in folder (Grid View)
        //show path on text View
        //if any file selected again repeate step 2 and 3
    }
    
    @IBAction func onImagesTap(sender: AnyObject) {
        selectedCategory = .Image
        self.fileList = self.getFileListForCategory(selectedCategory!)
        tableView.reloadData()
    }
    
    @IBAction func onVideoTap(sender: AnyObject) {
        selectedCategory = .Video
        self.fileList = self.getFileListForCategory(selectedCategory!)
        tableView.reloadData()
    }
    
    // MARK: - UITableView
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.fileList.count != 0 {
            return self.fileList.count
        }
        return 0;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: DataFilesRowCell? = self.tableView.dequeueReusableCellWithIdentifier("DataFilesRowCell") as? DataFilesRowCell
        if cell == nil {
            let topLevelObjects = NSBundle.mainBundle().loadNibNamed("DataFilesRowCell", owner: self, options: nil)
            cell = topLevelObjects[0] as? DataFilesRowCell;
        }
        let file:Files = fileList[indexPath.row] as Files
        cell!.fileSize.text = file.size
        cell!.fileTitle.text = file.title
        cell!.createdDate.text = file.createdDate
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //open file from location
        println("You selected cell #\(indexPath.row)!")
    }
    
    func getFileList() -> [Files] {
        self.fileList = dataManager.getFileList()
        return self.fileList
    }
    
    func getFileListForCategory(category:Category) -> [Files] {
        self.fileList = dataManager.getFileListForCategory(category)
        return self.fileList
    }
    
    // MARK: - Storage Service Call
    func storeData(data:NSData, fileName:String) -> NSString {
     return storageService.addBlob(data, name:fileName)
    }
    
    func getStoreData() {
        storageService.getBlob() //get all data
    }
    
    func getBlob() {
        
        client.getBlobs(container.objectAtIndex(0) as BlobContainer, withBlock: ({ (blobs, error) -> Void in
            if (error != nil) {
                NSLog("%@", error.localizedDescription)
            } else {
                NSLog("%i blobs were found in the images container…", blobs.count)
                if blobs.count != 0 {
                    self.blobArray = NSArray(array: blobs)
                }
                for  var index:Int = 0; index < self.blobArray.count; index++ {
                    NSLog("%@", self.blobArray.objectAtIndex(index) as Blob)
                }
            }
        }))
    }
    
    func deleteStoreData(data:NSData) {
        storageService.deleteBlob(data)
    }
    
}

