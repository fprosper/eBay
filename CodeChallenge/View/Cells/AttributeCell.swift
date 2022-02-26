//
//  AttributeCell.swift
//  CodeChallenge
//
//  Created by Fabrizio Prosperi on 26/02/2022.
//

import UIKit

class AttributeCell: UITableViewCell {
    
    @IBOutlet weak var keyValue: UILabel!
    @IBOutlet weak var valueLabel: UILabel!

    func setup(with attribute: (String, String)){
        keyValue.text = attribute.0
        valueLabel.text = attribute.1
    }
 
}
