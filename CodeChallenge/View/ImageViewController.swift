//
//  ImageViewController.swift
//  CodeChallenge
//
//  Created by Fabrizio Prosperi on 27/02/2022.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
   
    var imageURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = imageURL {
            imageView.loadImage(at: url)
        }
    }
    
    @IBAction func cancelClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
