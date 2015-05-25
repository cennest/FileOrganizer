//
//  DataFilesRowCell.swift
//  dropFiles
//
//  Created by Kanchan on 25/05/15.
//  Copyright (c) 2015 Cennest. All rights reserved.
//

import UIKit

class DataFilesRowCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var fileSize: UILabel!
    @IBOutlet weak var createdDate: UILabel!
    @IBOutlet weak var fileTitle: UILabel!
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
