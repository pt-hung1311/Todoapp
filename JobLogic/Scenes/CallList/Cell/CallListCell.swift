//
//  CallListCell.swift
//  JobLogic
//
//  Created by Pham Hung on 23/04/2022.
//

import UIKit

class CallListCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bindViewModel(call: Call) {
        nameLabel.text = call.name
        numberLabel.text = call.number
    }
    
}
