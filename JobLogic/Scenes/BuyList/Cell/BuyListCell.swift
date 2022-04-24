//
//  BuyListCell.swift
//  JobLogic
//
//  Created by Pham Hung on 23/04/2022.
//

import UIKit

class BuyListCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bindViewModel(item: Item) {
        nameLabel.text = item.name
        priceLabel.text = String(item.price)
        quantityLabel.text = String(item.quantity)
    }
    
}
