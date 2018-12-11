//
//  OfferClassesTableViewCell.swift
//  TutorsApp
//
//  Created by Adahid Galan on 12/8/18.
//  Copyright © 2018 UniversityHub. All rights reserved.
//

import UIKit

class OfferClassesTableViewCell: UITableViewCell {
    @IBOutlet weak var className: UILabel!
    @IBOutlet weak var checkbox: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
