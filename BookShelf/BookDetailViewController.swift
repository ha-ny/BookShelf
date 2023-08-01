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
    var data: Movie?

    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var releaseLabel: UILabel!
    @IBOutlet var runtimeLabel: UILabel!
    @IBOutlet var overviewLabel: UITextView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var likeButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = movieData[index]
        settingView()
    }
    
    func settingView(){
        guard let data = data else { return }
        title = data.title
        rateLabel.text = "평점: \(data.rate)"
        releaseLabel.text = data.releaseDate
        runtimeLabel.text = "러닝타임: \(data.runtime)분"
        overviewLabel.text = data.overview
        imageView.image = UIImage(named: data.title)
        likeButton.image = UIImage(systemName: data.like ? "heart.fill" : "heart")
    }
    
    @IBAction func likeButtonClick(_ sender: UIBarButtonItem) {
        self.data?.like.toggle()
        guard let data = data else { return }
        likeButton.image = UIImage(systemName: data.like ? "heart.fill" : "heart")
    }
    
    @IBAction func deleteButtonClick(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "알림", message: "삭제하시겠습니까?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "삭제", style: .default){_ in
            
            //data에 값 복사된건 main에서 사용 불가능
            movieData.remove(at: self.index)
            self.navigationController?.popViewController(animated: true)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}

