//
//  PlanTableViewCell.swift
//  ProcastiNot - Harsharan Rakhra App
//
//  Created by CoopStudent on 2022-07-29.
//

import UIKit

class PlanTableViewCell: UITableViewCell {

    @IBOutlet weak var TaskLabel: UILabel!
    @IBOutlet weak var PlanButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
