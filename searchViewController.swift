//
//  searchViewController.swift
//  BookShelf
//
//  Created by 김하은 on 2023/07/31.
//

import UIKit

class searchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "검색화면"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButton))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }

    @objc func closeButton() {
        //dismiss는 present일때
        //dismiss(animated: true)
        navigationController?.popViewController(animated: true)
    }
}
