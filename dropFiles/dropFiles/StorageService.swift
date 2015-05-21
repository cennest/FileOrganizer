//
//  StorageService.swift
//  dropFiles
//
//  Created by Kanchan on 21/05/15.
//  Copyright (c) 2015 Cennest. All rights reserved.
//

import Foundation
import UIKit

class AzureViewController: UIViewController, CloudStorageClientDelegate {
    var credential:AuthenticationCredential = AuthenticationCredential()
    var client:CloudStorageClient = CloudStorageClient()
    var container:NSArray = NSArray()
    var blobArray:NSArray = NSArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        credential = AuthenticationCredential(azureServiceAccount: "uploadanddownload", accessKey: "P2dEV/nSq0/1WV0BpWqyNZe6obmWRDMgqQ27WmcLxlqRX6AghcVAzEr7bPd3vplfSpPhBThDDPU3jAY2CySXLQ==")
        
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
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}

