//
//  BaseViewController.swift
//  CodeChallenge
//
//  Created by Fabrizio Prosperi on 26/02/2022.
//

import UIKit

class BaseViewController: UIViewController {
    
    let loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .large)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        return loader
    }()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    deinit {
        print("deinit \(self)")
    }
    
    // MARK: -
    internal func setupUI() {
        view.addSubview(loader)
        loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
