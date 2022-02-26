//
//  FeatureCell.swift
//  CodeChallenge
//
//  Created by Fabrizio Prosperi on 26/02/2022.
//

import UIKit

class FeatureCell: UITableViewCell {
    
    @IBOutlet weak var leftStackView: UIStackView!
    @IBOutlet weak var rightStackView: UIStackView!
    
    func setup(with features: [String]) {
        for i in 0..<features.count {
            let stackView = stackViewWithFeature(features[i])
            if i/2 > 0 {
                rightStackView.addArrangedSubview(stackView)
            } else {
                leftStackView.addArrangedSubview(stackView)
            }
        }
    }
    
    private func stackViewWithFeature(_ feature: String) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill //.trailing .lastBaseline
        stackView.distribution = .fill

        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 11, height: 15))
        imageView.image = UIImage(named: "Checkmark")
        stackView.addArrangedSubview(imageView)
        
        let stackViewHeightConstraint = NSLayoutConstraint(item: stackView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20)
        let imageViewWidthConstraint = NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 11)
        let imageViewHeightConstraint = NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 15)
        
        stackView.addConstraint(stackViewHeightConstraint)
        
        imageView.addConstraints([imageViewWidthConstraint, imageViewHeightConstraint])

        let label = UILabel()
        label.text = feature
        label.font = UIFont.systemFont(ofSize: 12)
        stackView.addArrangedSubview(label)
        return stackView
    }
}
