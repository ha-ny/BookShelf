//
//  BookShelfCollectionViewController.swift
//  BookShelf
//
//  Created by 김하은 on 2023/07/31.
//

import UIKit

var movieData = MovieInfo().movie

class BookShelfCollectionViewController: UICollectionViewController {
    
    let cellIdentifier = "BookShelfCollectionViewCell"
    let detailViewIdentifier = "BookDetailViewController"
    let searchViewIdentifier = "searchViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
        
        designCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    func designCollectionView(){
        
        let spacing: CGFloat = 15
        let width = UIScreen.main.bounds.width - (spacing * 4) //원하는 칸 + 1
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: width / 3, height: width / 2) // 같은 숫자로 하면 1:1
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
    }
    
    @IBAction func searchButtonClick(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(identifier: searchViewIdentifier)
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! BookShelfCollectionViewCell
        cell.titleLabel.text = movieData[indexPath.row].title
        cell.imageView.image = UIImage(named: movieData[indexPath.row].title)
        
        let heart = movieData[indexPath.row].like ? "heart.fill" : "heart"
        cell.likeButton.setImage(UIImage(systemName: heart), for: .normal)
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonClick), for: .touchUpInside)
        
        return cell
    }
    
    @objc func likeButtonClick(_ sender: UIButton){
        movieData[sender.tag].like.toggle()
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: detailViewIdentifier) as! BookDetailViewController
        vc.index = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
    }
}
