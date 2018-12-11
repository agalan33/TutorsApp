//
//  DeptTableViewCell.swift
//  TutorsApp
//
//  Created by Adahid Galan on 12/5/18.
//  Copyright © 2018 UniversityHub. All rights reserved.
//

import UIKit

class DeptTableViewCell: UITableViewCell {

    @IBOutlet weak var deptName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
