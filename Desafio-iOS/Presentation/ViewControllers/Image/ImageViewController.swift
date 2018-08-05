//
//  ImageViewController.swift
//  Desafio-iOS
//
//  Created by Marcos Kobuchi on 05/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import UIKit

protocol ImageViewControllerProtocol: class {
    var image: UIImage? { get set }
}

class ImageViewController: UIViewController, ImageViewControllerProtocol {

    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage? {
        didSet { self.imageView?.image = self.image }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = self.image
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
