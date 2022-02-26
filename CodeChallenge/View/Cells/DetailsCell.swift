//
//  DetailsCell.swift
//  CodeChallenge
//
//  Created by Fabrizio Prosperi on 26/02/2022.
//

import UIKit

class DetailsCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var visitsLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!

    func setup(with viewModel: AdViewModel) {
        titleLabel.text = viewModel.title
        amountLabel.text = viewModel.amount
        dateLabel.text = viewModel.date
        visitsLabel.text = viewModel.visits
        idLabel.text = viewModel.id
        locationLabel.text = viewModel.location
    }
}
