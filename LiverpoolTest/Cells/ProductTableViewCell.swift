//
//  ProductTableViewCell.swift
//  LiverpoolTest
//
//  Created by Eon Igniting on 19/06/21.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var nameProduct: UILabel!
    @IBOutlet weak var priceWithoutDicount: UILabel!
    @IBOutlet weak var priceWithDiscount: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
