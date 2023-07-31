//
//  BookDetailViewController.swift
//  BookShelf
//
//  Created by 김하은 on 2023/07/31.
//

import UIKit

class BookDetailViewController: UIViewController {

    var pushTitle = ""
    
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = pushTitle
        imageView.image = UIImage(named: pushTitle)
    }


}

