//
//  AroundTableViewController.swift
//  BookShelf
//
//  Created by 김하은 on 2023/08/02.
//

import UIKit
import Alamofire
import SwiftyXMLParser

class AroundTableViewController: UITableViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    static let identifier = "AroundTableViewController"

    @IBOutlet var lastViewCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let nib = UINib(nibName: lastViewCellIdentifier, bundle: nil)
//        lastViewCollectionView.register(nib, forCellWithReuseIdentifier: lastViewCellIdentifier)
//
        tableView.rowHeight = 100
        collectionViewDesign()
        
//        let url = "http://www.aladin.co.kr/ttb/api/ItemList.aspx?ttbkey=\(APIKey.aladin)&QueryType=Bestseller"
//        AF.request(url, method: .get).responseData { response in
//            if let data = response.data {
//                let xml = XML.parse(data)
//                print(xml)
//            }
//        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //data = MovieInfo.movie.sorted(by: { $0.click > $1.click })
        tableView.reloadData()
        lastViewCollectionView.reloadData()
    }
}

//TableView
extension AroundTableViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // let cell = tableView.dequeueReusableCell(withIdentifier: "aroundCell")!
//        cell.textLabel?.text = data[indexPath.row].title
//        cell.detailTextLabel?.text = "\( data[indexPath.row].releaseDate) /  \( data[indexPath.row].rate)점"
//
//        cell.imageView?.image = UIImage(named:  data[indexPath.row].title)

        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "베스트셀러"
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        guard let index = MovieInfo.movie.firstIndex(where: { $0.title == data[indexPath.row].title }) else { return }
//
//        let vc = storyboard?.instantiateViewController(withIdentifier: detailViewIdentifier) as! BookDetailViewController
//        vc.index = index
//        let nav = UINavigationController(rootViewController: vc)
//        nav.modalPresentationStyle = .fullScreen
//        present(nav, animated: true)
    }
}

//collectionView
extension AroundTableViewController{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MovieInfo.lastViewArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: lastViewCellIdentifier, for: indexPath) as! LastViewCollectionViewCell
//        cell.movieImage.image = UIImage(named: MovieInfo.lastViewArray[indexPath.row])
        return UICollectionViewCell()
    }
    
    func collectionViewDesign(){
        lastViewCollectionView.delegate = self
        lastViewCollectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3, height: 170)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        lastViewCollectionView.collectionViewLayout = layout
        lastViewCollectionView.isScrollEnabled = true
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        //guard let index = MovieInfo.movie.firstIndex(where: { $0.title == MovieInfo.lastViewArray[indexPath.row] }) else { return }
        
//        let vc = storyboard?.instantiateViewController(withIdentifier: detailViewIdentifier) as! BookDetailViewController
//        vc.index = index
//        let nav = UINavigationController(rootViewController: vc)
//        nav.modalPresentationStyle = .fullScreen
//        present(nav, animated: true)
    }
}
