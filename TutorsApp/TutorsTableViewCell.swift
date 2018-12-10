//
//  TutorsTableViewCell.swift
//  TutorsApp
//
//  Created by Adahid Galan on 12/9/18.
//  Copyright © 2018 UniversityHub. All rights reserved.
//

import UIKit
import Cosmos
class TutorsTableViewCell: UITableViewCell {

    @IBOutlet weak var tutorsName: UILabel!
    @IBOutlet weak var rating: CosmosView!
    @IBOutlet weak var classesOffering: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
