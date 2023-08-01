//
//  BookShelfCollectionViewController.swift
//  BookShelf
//
//  Created by 김하은 on 2023/07/31.
//

import UIKit

class BookShelfCollectionViewController: UICollectionViewController {
    
    let movieData = MovieInfo().movie
    let colorArray: [UIColor] = [.red, .orange, .yellow, .green, .blue, .brown, .purple, .cyan, .lightGray].shuffled()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "BookShelfCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "BookShelfCollectionViewCell")
        
        designCollectionView()
    }
    
    func designCollectionView(){
        
        //cell estimated size none으로 인터페이스 빌더에서 설정할 것
        let spacing: CGFloat = 15
        let width = UIScreen.main.bounds.width - (spacing * 3) //원하는 칸 + 1
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: width / 2, height: width / 1.5) // 1:1
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
        cell.backView.backgroundColor = colorArray[indexPath.row]
        cell.backView.layer.cornerRadius = 8
        cell.titleLabel.text = movieData[indexPath.row].title
        cell.imageView.image = UIImage(named: movieData[indexPath.row].title)
        cell.rateLabel.text = String(movieData[indexPath.row].rate)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "BookDetailViewController") as! BookDetailViewController
        vc.pushData = movieData[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
