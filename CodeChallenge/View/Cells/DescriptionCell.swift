//
//  DescriptionCell.swift
//  CodeChallenge
//
//  Created by Fabrizio Prosperi on 26/02/2022.
//

import UIKit

class DescriptionCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    func setup(with description: String) {
        label.text = description
    }

}
