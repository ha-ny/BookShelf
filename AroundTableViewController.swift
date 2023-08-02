//
//  AroundTableViewController.swift
//  BookShelf
//
//  Created by 김하은 on 2023/08/02.
//

import UIKit

var lastViewArray = Array(repeating: "", count: 5)

class AroundTableViewController: UITableViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    let lastViewCellIdentifier = "LastViewCollectionViewCell"
    let detailViewIdentifier = "BookDetailViewController"
    
    // lazy -> data를 호출할때 생성
    lazy var data = MovieInfo.movie.sorted(by: { $0.click > $1.click })
    
    @IBOutlet var lastViewCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
        lastViewCollectionView.delegate = self
        lastViewCollectionView.dataSource = self
        collectionViewDesign()
        let nib = UINib(nibName: lastViewCellIdentifier, bundle: nil)
        lastViewCollectionView.register(nib, forCellWithReuseIdentifier: lastViewCellIdentifier)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        data = MovieInfo.movie.sorted(by: { $0.click > $1.click })
        tableView.reloadData()
        lastViewCollectionView.reloadData()
        print(lastViewArray)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "aroundCell")!
        cell.textLabel?.text = data[indexPath.row].title
        cell.detailTextLabel?.text = "\( data[indexPath.row].releaseDate) /  \( data[indexPath.row].rate)점"
        
        cell.imageView?.image = UIImage(named:  data[indexPath.row].title)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "요즘 인기 작품"
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: lastViewCellIdentifier, for: indexPath) as! LastViewCollectionViewCell
        cell.movieImage.image = UIImage(named: lastViewArray[indexPath.row])
        return cell
    }
    
    func collectionViewDesign(){
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3, height: 170)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        lastViewCollectionView.collectionViewLayout = layout
        lastViewCollectionView.isScrollEnabled = true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let index = MovieInfo.movie.firstIndex(where: { $0.title == data[indexPath.row].title }) else { return }
        
        let vc = storyboard?.instantiateViewController(withIdentifier: detailViewIdentifier) as! BookDetailViewController
        vc.index = index
        vc.viewName = "AroundTableViewController"
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(lastViewArray[indexPath.row])
        guard let index = MovieInfo.movie.firstIndex(where: { $0.title == lastViewArray[indexPath.row] }) else { return }
        
        let vc = storyboard?.instantiateViewController(withIdentifier: detailViewIdentifier) as! BookDetailViewController
        vc.index = index
        vc.viewName = "AroundTableViewController"
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
