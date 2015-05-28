//
//  Files+Enhance.swift
//  dropFiles
//
//  Created by Kanchan on 12/05/15.
//  Copyright (c) 2015 Cennest. All rights reserved.
//

import Foundation

extension Files {
    
    func addFileDetail(title:String, fileID:Int, size:String, location:String, createdDate:String , modifiedDate:String , category: Category, isDownloaded:Bool, userID:Int) -> Files {
        println(category)
        self.title = title
        self.fileID = fileID
        self.size = size
        self.location = location
        self.createdDate = createdDate
        self.modifiedDate = modifiedDate
        self.category = category.rawValue
        self.isDownloaded = isDownloaded
        self.userID = userID
        return self
    }   
}