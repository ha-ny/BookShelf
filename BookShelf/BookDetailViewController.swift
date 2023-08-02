//
//  BookDetailViewController.swift
//  BookShelf
//
//  Created by 김하은 on 2023/07/31.
//

import UIKit

class BookDetailViewController: UIViewController {

    //메인화면에서 값 세팅해줌
    var index: Int = 0
    var viewName: String?
    
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var releaseLabel: UILabel!
    @IBOutlet var runtimeLabel: UILabel!
    @IBOutlet var overviewLabel: UITextView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var likeButton: UIBarButtonItem!
    @IBOutlet var backButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.isHidden = true
        settingView()
    }
    
    @objc func settingView(){

        let data = MovieInfo.movie[index]
        
        if viewName == "AroundTableViewController"{
            backButton.isHidden = false
            releaseLabel.text = "\(data.title)\n\(data.releaseDate)"
        }else{
            title = data.title
            releaseLabel.text = data.releaseDate
        }

        rateLabel.text = "평점: \(data.rate)"
        runtimeLabel.text = "러닝타임: \(data.runtime)분"
        overviewLabel.text = data.overview
        imageView.image = UIImage(named: data.title)
        likeButton.image = UIImage(systemName: data.like ? "heart.fill" : "heart")
        MovieInfo.movie[index].click += 1
        MovieInfo.lastViewArray.insert(data.title, at: 0)
    }
    
    @IBAction func likeButtonClick(_ sender: UIBarButtonItem) {
        MovieInfo.movie[index].like.toggle()
        likeButton.image = UIImage(systemName: MovieInfo.movie[index].like ? "heart.fill" : "heart")
    }
    
    @IBAction func deleteButtonClick(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "알림", message: "삭제하시겠습니까?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "삭제", style: .default){_ in
            
            MovieInfo.movie.remove(at: self.index)
            self.navigationController?.popViewController(animated: true)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    @IBAction func backbuttonClick(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}
