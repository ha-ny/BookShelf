//
//  SearchCollectionViewController.swift
//  BookShelf
//
//  Created by 김하은 on 2023/08/03.
//

import UIKit

class SearchCollectionViewController: UICollectionViewController, UISearchBarDelegate {

    var searchList = [Int]()
    let cellIdentifier = "BookShelfCollectionViewCell"
    let detailViewIdentifier = "BookDetailViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "검색화면"
        
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButton))
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        let searchBar = UISearchBar()
        navigationItem.titleView = searchBar
        searchBar.placeholder = "검색어를 입력해주세요."
        searchBar.delegate = self
        searchBar.setShowsCancelButton(true, animated: true)
        designCollectionView()
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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchList.removeAll()
        
        for (index, movie) in MovieInfo.movie.enumerated(){
            if movie.title.contains(searchBar.text ?? ""){
                searchList.append(index)
            }
        }
        
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBarSearchButtonClicked(searchBar)
    }
    
    @objc func closeButton() {
        //dismiss는 present일때
        //dismiss(animated: true)
        navigationController?.popViewController(animated: true)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return searchList.count
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBarSearchButtonClicked(searchBar)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! BookShelfCollectionViewCell
        
        let data = MovieInfo.movie[searchList[indexPath.row]]
        cell.titleLabel.text = data.title
        cell.imageView.image = UIImage(named: data.title)
        cell.likeButton.isHidden = true
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: detailViewIdentifier) as! BookDetailViewController
        vc.index = searchList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
