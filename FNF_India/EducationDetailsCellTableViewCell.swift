//
//  EducationDetailsCellTableViewCell.swift
//  FNF_India
//
//  Created by mercurius solutions pvt ltd on 05/03/20.
//  Copyright © 2020 mercurius solutions pvt ltd. All rights reserved.
//

import UIKit

class EducationDetailsCellTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         cardView.layer.shadowColor = UIColor.black.cgColor
         cardView.layer.shadowOffset = CGSize(width: 0, height: 0);
         cardView.layer.shadowOpacity = 0.25
         cardView.layer.shadowRadius = 2
         cardView.layer.masksToBounds = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
