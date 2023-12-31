//
//  BookShelfCollectionViewCell.swift
//  BookShelf
//
//  Created by 김하은 on 2023/07/31.
//

import UIKit

class BookShelfCollectionViewCell: UICollectionViewCell {
    static let identifier = "BookShelfCollectionViewCell"
    
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
}
