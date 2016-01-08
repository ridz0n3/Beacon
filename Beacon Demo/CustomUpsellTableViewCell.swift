//
//  CustomUpsellTableViewCell.swift
//  Beacon Demo
//
//  Created by ME-Tech Mac User 1 on 1/5/16.
//  Copyright © 2016 Me-tech. All rights reserved.
//

import UIKit

class CustomUpsellTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var upsellImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
