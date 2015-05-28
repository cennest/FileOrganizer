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
    
    
    func setContainer() -> CloudStorageClient {
        credential = AuthenticationCredential(azureServiceAccount: StorageServiceConstants.kAzureAccountName, accessKey:StorageServiceConstants.kAzureAccountKey)
        
        client = CloudStorageClient(credential: credential)
        
        //        let appDelegate  = UIApplication.sharedApplication().keyWindow
        //        var viewController = appDelegate?.rootViewController as FileOraganizerViewController
        
        return client
    }
    
    func getBlobContainer() { // get all blob containers
        var containers = NSArray()
        var error = NSError()
        
        client.getBlobContainersWithBlock({ (containers, error) -> Void in
            if (error != nil) {
                NSLog("%@", error.localizedDescription)
            } else {
                NSLog(StorageServiceConstants.kLogMessageForContainerFound, containers.count)
                if containers.count != 0 {
                    self.container = NSArray(array: containers)
                }
            }
        })
    }
    
    func addBlob(data:NSData, name:String) -> NSString {
        var contentType:NSString = NSString(format: StorageServiceConstants.kBlobContentType, StorageServiceConstants.kBlobBoundry)
        client.addBlobToContainer(container.objectAtIndex(0) as BlobContainer, blobName:name, contentData: data, contentType: contentType)
        var url = container.objectAtIndex(0).URL
        return "\(url)/\(name)"
    }
    
    func getBlob() {
        
        client.getBlobs(container.objectAtIndex(0) as BlobContainer, withBlock: ({ (blobs, error) -> Void in
            if (error != nil) {
                NSLog("%@", error.localizedDescription)
            } else {
                NSLog(StorageServiceConstants.kLogMessageForBlobFoundMessage, blobs.count)
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

