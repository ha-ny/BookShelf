//
//  BookShelfCollectionViewController.swift
//  BookShelf
//
//  Created by 김하은 on 2023/07/31.
//

import UIKit

class BookShelfCollectionViewController: UICollectionViewController {
    
    var movieData = MovieInfo().movie{
        didSet{
            print("찍힘?")
            collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "BookShelfCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "BookShelfCollectionViewCell")
        
        designCollectionView()
    }
    
    func designCollectionView(){
        
        //cell estimated size none으로 인터페이스 빌더에서 설정할 것
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
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "searchViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookShelfCollectionViewCell", for: indexPath) as! BookShelfCollectionViewCell
        cell.titleLabel.text = movieData[indexPath.row].title
        cell.imageView.image = UIImage(named: movieData[indexPath.row].title)
        
        let heart = movieData[indexPath.row].like ? "heart.fill" : "heart"
        cell.likeButton.setImage(UIImage(systemName: heart), for: .normal)
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonClick), for: .touchUpInside)
        
        return cell
    }
    
    @objc func likeButtonClick(_ sender: UIButton){
        print(sender.tag)
        movieData[sender.tag].like.toggle()
        print(movieData[sender.tag])
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "BookDetailViewController") as! BookDetailViewController
        vc.pushData = movieData[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
