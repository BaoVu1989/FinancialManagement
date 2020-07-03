//
//  CellExpenseTableViewCell.swift
//  Financial Individual
//
//  Created by Bao Vu on 3/30/20.
//  Copyright © 2020 Bao Vu. All rights reserved.
//

import UIKit

class CellExpenseTableViewCell: UITableViewCell {

    @IBOutlet weak var imgCategory: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
