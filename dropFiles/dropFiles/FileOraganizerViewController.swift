//
//  FileOraganizerViewController.swift
//  dropFiles
//
//  Created by Kanchan on 18/05/15.
//  Copyright (c) 2015 Cennest. All rights reserved.
//

import Foundation
import UIKit

class FileOraganizerViewController : UIViewController , UITableViewDelegate, UITableViewDataSource , CloudStorageClientDelegate {
    var credential:AuthenticationCredential = AuthenticationCredential()
    var client:CloudStorageClient = CloudStorageClient()
    var container:NSArray = NSArray()
    var blobArray:NSArray = NSArray()
    
    var fileList = [Files]()
    var dataManager = DataManager.sharedDataAccess()
    var storageService:StorageService = StorageService()
    var selectedCategory:Category?
    var selectedTab:SelectionOptions?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "DataFilesRowCell")
        self.tableView.delegate = self
        credential = AuthenticationCredential(azureServiceAccount: "uploadanddownload", accessKey:"P2dEV/nSq0/1WV0BpWqyNZe6obmWRDMgqQ27WmcLxlqRX6AghcVAzEr7bPd3vplfSpPhBThDDPU3jAY2CySXLQ==")
        
        client = CloudStorageClient(credential: credential)
        
        client.delegate = self
        
        // get all blob containers
        var containers = NSArray()
        var error = NSError()
        
        client.getBlobContainersWithBlock({ (containers, error) -> Void in
            if (error != nil) {
                NSLog("%@", error.localizedDescription)
            } else {
                NSLog("%i containers were found…", containers.count)
                if containers.count != 0 {
                    self.container = NSArray(array: containers)
                }
            }
        })
        
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
        var formatter = NSDateFormatter()
        formatter.dateFromString("dd-MM-yyyy HH:mm")
        
        
        
        
        var image:UIImage = UIImage(named:"images.png")!
        var data:NSData = UIImagePNGRepresentation(image);
        
        //service call n then set fileID
        var res = dataManager.createFile("Image1", fileID: 1, size:"3kb", location: "f", createdDate:"1/2/90" , modifiedDate:"1/2/90", categoryID: 1, isDownloaded: false, userID: 1)
        var res1 = dataManager.createFile("Image2", fileID: 1, size:"3kb", location: "f", createdDate:"1/2/90" , modifiedDate:"1/2/90", categoryID: 2, isDownloaded: false, userID: 1)
        var res2 = dataManager.createFile("Image3", fileID: 1, size:"3kb", location: "f", createdDate:"1/2/90" , modifiedDate:"1/2/90", categoryID: 3, isDownloaded: false, userID: 1)
        NSLog("%@", res)
        
        
        
        //add cell in table view
    }
    
    @IBAction func onCreateNewFolderTap(sender: AnyObject) {
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
        selectedTab = .AllFolder
        self.fileList = []
        tableView.reloadData()
        //fetch path and load data that are contain in folder (Grid View)
        //show path on text View
        //if any file selected again repeate step 2 and 3
    }
    
    @IBAction func onImagesTap(sender: AnyObject) {
        selectedCategory = .Image
        selectedTab = .Image
        self.fileList = self.getFileListForCategory(selectedCategory!)
        tableView.reloadData()
    }
    
    @IBAction func onVideoTap(sender: AnyObject) {
        selectedCategory = .Video
        selectedTab = .Video
        self.fileList = self.getFileListForCategory(selectedCategory!)
        tableView.reloadData()
    }
    
    //tableView
    
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
    
    //Storage Service
    func storeData(data:NSData) {
        storageService.addBlob(data)
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

extension FileOraganizerViewController {
    
    func refrestTableView(selectedTab:SelectionOptions) {
        //sort data according to category
    }
    
    
    
}
