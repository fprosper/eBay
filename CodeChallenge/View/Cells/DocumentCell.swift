//
//  DocumentCell.swift
//  CodeChallenge
//
//  Created by Fabrizio Prosperi on 26/02/2022.
//

import UIKit

class DocumentCell: UITableViewCell {

    func setup(with document: Document) {
        self.imageView?.image = UIImage(named: "Pdf")
        self.textLabel?.text = document.title
        self.accessoryType = .disclosureIndicator
    }

}
