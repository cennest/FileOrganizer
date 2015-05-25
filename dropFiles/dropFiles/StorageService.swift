//
//  StorageService.swift
//  dropFiles
//
//  Created by Kanchan on 21/05/15.
//  Copyright (c) 2015 Cennest. All rights reserved.
//

import Foundation
import UIKit

class StorageService: CloudStorageClientDelegate {
    var credential:AuthenticationCredential = AuthenticationCredential()
    var client:CloudStorageClient = CloudStorageClient()
    var container:NSArray = NSArray()
    var blobArray:NSArray = NSArray()
    
    
    func setContainer() {
        credential = AuthenticationCredential(azureServiceAccount: "uploadanddownload", accessKey:"P2dEV/nSq0/1WV0BpWqyNZe6obmWRDMgqQ27WmcLxlqRX6AghcVAzEr7bPd3vplfSpPhBThDDPU3jAY2CySXLQ==")
        
        client = CloudStorageClient(credential: credential)
        
        
        let appDelegate  = UIApplication.sharedApplication().keyWindow
        var viewController = appDelegate?.rootViewController as FileOraganizerViewController
        client.delegate = viewController
        
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
    
    func addBlob (data:NSData) {
        var boundary:NSString = "random string of your choosing"
        var contentType:NSString = NSString(format: "multipart/form-data; boundary=%@", boundary)
        client.addBlobToContainer(container.objectAtIndex(0) as BlobContainer, blobName:"images.png", contentData: data, contentType: contentType)
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
    
    func deleteBlob (data:NSData) {
        client.deleteBlob(blobArray.objectAtIndex(blobArray.count - 3) as Blob, withBlock:({(error) -> Void in
            if (error != nil) {
                NSLog("%@", error.localizedDescription)
            } else {
                NSLog("Delete Sucessfully...")
            }
            
        }))
    }
}

