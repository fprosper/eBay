//
//  Extensions.swift
//  CodeChallenge
//
//  Created by Fabrizio Prosperi on 26/02/2022.
//

import UIKit

// MARK: - String
extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

// MARK: - UIImageView
extension UIImageView {
  func loadImage(at url: URL) {
    ImageLoader.shared.load(url, for: self)
  }

  func cancelLoadImage() {
    ImageLoader.shared.cancel(for: self)
  }
}

// MARK: - NSObject
extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}

