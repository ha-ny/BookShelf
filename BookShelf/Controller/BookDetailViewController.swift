//
//  BookDetailViewController.swift
//  BookShelf
//
//  Created by 김하은 on 2023/07/31.
//

import UIKit
import RealmSwift

class BookDetailViewController: UIViewController, UITextViewDelegate {

    static let identifier = "BookDetailViewController"
    
    //메인화면에서 값 세팅
    var bookData: Book?
    
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var releaseLabel: UILabel!
    @IBOutlet var runtimeLabel: UILabel!
    @IBOutlet var overviewLabel: UITextView!
    @IBOutlet var memoLabel: UITextView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var likeButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButton))
        memoLabel.delegate = self
        settingView()
    }
    
    @objc func settingView(){

        guard let data = bookData else { return }

        title = data.title
//        releaseLabel.text = data.releaseDate
//        rateLabel.text = "평점: \(data.rate)"
//        runtimeLabel.text = "러닝타임: \(data.runtime)분"
//        overviewLabel.text = data.overview
        imageView.kf.setImage(with: URL(string: data.thumbnail))
//        likeButton.image = UIImage(systemName: data.like ? "heart.fill" : "heart")
//        memoLabel.text = data.memo
//        MovieInfo.movie[index].click += 1
        MovieInfo.lastViewArray.insert(data.title, at: 0)
        if MovieInfo.lastViewArray.count > 5{
            MovieInfo.lastViewArray.removeLast()
        }
        
    }
    
    @objc func closeButton(){
        
        if let _ = (self.presentingViewController){
            dismiss(animated: true)
        }else{
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func likeButtonClick(_ sender: UIBarButtonItem) {
        
        guard let realm = try? Realm(), let data = bookData else { return }
        
        let task = BookTable(thumbnail: data.thumbnail, title: data.title, contents: data.contents)
        
        try? realm.write {
            realm.add(task)
            likeButton.image = UIImage(systemName: "heart.fill")
        }
    }
    
    @IBAction func deleteButtonClick(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "알림", message: "삭제하시겠습니까?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "삭제", style: .default){_ in
            
            //삭제되면 Index out of range.. 복사본 만듬
            for i in (0...MovieInfo.lastViewArray.count - 1).reversed(){
//                if MovieInfo.movie[self.index].title == MovieInfo.lastViewArray[i]{
//                    MovieInfo.lastViewArray.remove(at: i)
//                }
            }

            //MovieInfo.movie.remove(at: self.index)
            self.closeButton()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    func textViewDidChange(_ textView: UITextView) {
       // MovieInfo.movie[index].memo = memoLabel.text
    }
}
