//
//  FileOraganizerViewController.swift
//  dropFiles
//
//  Created by Kanchan on 18/05/15.
//  Copyright (c) 2015 Cennest. All rights reserved.
//

import Foundation
import UIKit

class FileOraganizerViewController : UIViewController , UITableViewDelegate, UITableViewDataSource {
    var selectedCategory:Category?
    var selectedTab:SelectionOptions?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var items: [String] = ["We", "Heart", "Swift"]
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var sideBarView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func onDeleteTap(sender: AnyObject) {
        //delete file from db
        //refresh db
        //
    }
    
    @IBAction func onDownloadTap(sender: AnyObject) {
        
        //add location in db
    }
    
    @IBAction func onUploadTap(sender: AnyObject) {
//        var image = UIImage(named:"trash.png")
//        var n = image?.size
//        var imgData:NSData = UIImagePNGRepresentation(image);
//        
//        let url = NSURL(string:"/Users/kanchan/Documents/FileOrganizer/dropFiles/dropFiles/images.png")
//        let data = NSData(contentsOfURL: url!)
        

        
        //add cell in table view
    }
    
//    func openfiledialog (windowTitle: String, message: String, filetypelist: String) -> String
//    {
//        var path: String = ""
//        var finished: Bool = false
//        
////        suspendprocess (0.02) // Wait 20 ms., enough time to do screen updates regarding to the background job, which calls this function
//        dispatch_async(dispatch_get_main_queue())
//            {
//                var myFiledialog = NSOpenPanel()
//                var fileTypeArray: [String] = filetypelist.componentsSeparatedByString(",")
//                
//                myFiledialog.prompt = "Open"
//                myFiledialog.worksWhenModal = true
//                myFiledialog.allowsMultipleSelection = false
//                myFiledialog.canChooseDirectories = false
//                myFiledialog.resolvesAliases = true
//                myFiledialog.title = windowTitle
//                myFiledialog.message = message
//                myFiledialog.allowedFileTypes = fileTypeArray
//                
//                let void = myFiledialog.runModal()
//                
//                var chosenfile = myFiledialog.URL // Pathname of the file
//                
//                if (chosenfile != nil)
//                {
//                    path = chosenfile!.absoluteString!
//                }
//                finished = true
//        }
//        
//        while not(finished)
//        {
//            suspendprocess (0.001) // Wait 1 ms., loop until main thread finished
//        }
        
//        return (path)
//    }
    
//    func not (b: Bool) -> Bool
//    {
//        return (!b)
//    }
//    
//    func suspendprocess (t: Double)
//    {
//        var secs: Int = Int(abs(t))
//        var nanosecs: Int = Int(frac(abs(t)) * 1000000000)
//        var time = timespec(tv_sec: secs, tv_nsec: nanosecs)
//        let result = nanosleep(&time, nil)
//    }
    
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
        //fetch data from db
        //load data on table view
        //observe if ant file selected
    }
    @IBAction func onAllFolderTap(sender: AnyObject) {
        selectedTab = .AllFolder
        //fetch path and load data that are contain in folder (Grid View)
        //show path on text View
        //if any file selected again repeate step 2 and 3
    }
    
    @IBAction func onImagesTap(sender: AnyObject) {
        selectedCategory = .Image
        selectedTab = .Image
    }
    
    @IBAction func onVideoTap(sender: AnyObject) {
        selectedCategory = .Video
        selectedTab = .Video
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        cell.textLabel.text = self.items[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //open file from location
        println("You selected cell #\(indexPath.row)!")
    }
    
    
}

extension FileOraganizerViewController {

    func refrestTableView(selectedTab:SelectionOptions) {
    //sort data according to category
    }
    
    
    
}
