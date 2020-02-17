//
//  DetailViewController.swift
//  Storm Viewer
//
//  Created by Boris Nikolaev Borisov on 13/02/2020.
//  Copyright © 2020 Boris Nikolaev Borisov. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var selectedIndex: Int = 0
    var totalSize: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Picture \(selectedIndex) of \(totalSize)"
        navigationItem.largeTitleDisplayMode = .never
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = false
    }

}
