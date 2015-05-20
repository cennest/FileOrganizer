//
//  Files+Enhance.swift
//  dropFiles
//
//  Created by Kanchan on 12/05/15.
//  Copyright (c) 2015 Cennest. All rights reserved.
//

import Foundation

extension Files {
    
    func insertNewFile(title:String, fileID:NSNumber, size:String, location:String, createdDate:String , modifiedDate:String , categoryID: NSNumber, isDownloaded:Bool, userID:NSNumber) -> Files {
        
        self.title = title
        self.fileID = 1
        self.size = size
        self.location = location
        self.createdDate = createdDate
        self.modifiedDate = modifiedDate
        self.categoryID = categoryID
        self.isDownloaded = isDownloaded
        self.userID = userID
        return self
    }   
}