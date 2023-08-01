//
//  BookDetailViewController.swift
//  BookShelf
//
//  Created by 김하은 on 2023/07/31.
//

import UIKit

class BookDetailViewController: UIViewController {

    var pushData = MovieInfo().movie[0]
    
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var releaseLabel: UILabel!
    @IBOutlet var runtimeLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = pushData.title
        rateLabel.text = String(pushData.rate)
        releaseLabel.text = pushData.releaseDate
        runtimeLabel.text = "\(pushData.runtime)분"
        overviewLabel.text = pushData.overview
        imageView.image = UIImage(named: pushData.title)
    }
}

