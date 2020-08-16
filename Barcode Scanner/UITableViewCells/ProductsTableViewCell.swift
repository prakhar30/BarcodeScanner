//
//  ProductsTableViewCell.swift
//  Barcode Scanner
//
//  Created by Prakhar Tripathi on 16/08/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

class ProductsTableViewCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setValues(product: Product) {
        self.productImageView.image = UIImage(named: product.image)
        self.productNameLabel.text = product.name
        self.productPriceLabel.text = product.price
    }

}
