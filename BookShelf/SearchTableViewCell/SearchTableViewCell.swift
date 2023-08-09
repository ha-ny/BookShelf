//
//  SearchTableViewCell.swift
//  BookShelf
//
//  Created by 김하은 on 2023/08/09.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    static let identifier = "SearchTableViewCell"

    @IBOutlet var bookImageView: UIImageView!
    @IBOutlet var bookNameLabel: UILabel!
    @IBOutlet var contentsLabel: UILabel!
}
