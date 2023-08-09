//
//  SearchTableViewController.swift
//  BookShelf
//
//  Created by 김하은 on 2023/08/09.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class SearchTableViewController: UITableViewController {

    static let identifier = "SearchTableViewController"
    let searchBar = UISearchBar()
    var bookData: [Book] = []
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designNavigationItem()
        
        let nib = UINib(nibName: SearchTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: SearchTableViewCell.identifier)
        
        tableView.rowHeight = 150
        tableView.prefetchDataSource = self
        searchBar.delegate = self
        title = "검색화면"
    }

    @objc func closeButton(){
        navigationController?.popViewController(animated: true)
    }
}

//tableView
extension SearchTableViewController: UITableViewDataSourcePrefetching{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = bookData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier) as! SearchTableViewCell
        cell.bookImageView.kf.setImage(with: URL(string: data.thumbnail))
        cell.bookNameLabel.text = data.title
        cell.contentsLabel.text = data.contents
        return cell
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths{
            if bookData.count - 1 == indexPath.row && page < 50{
                page += 1
                bookAPI()
            }
        }
    }

    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) { }
}

//API
extension SearchTableViewController{
    func bookAPI(){
        let text = searchBar.text?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = "https://dapi.kakao.com/v3/search/book?query=\(text!)&size=20&page=\(page)"
        AF.request(url, method: .get, headers: ["Authorization": "KakaoAK \(APIKey.kakao)"]).responseJSON { respons in
            switch respons.result{
            case .success(let value):
                let json = JSON(value)
                for item in json["documents"].arrayValue{
                    self.bookData.append(Book(thumbnail: item["thumbnail"].stringValue, title: item["title"].stringValue, contents: item["contents"].stringValue))
                }
                print(json)
                self.tableView.reloadData()
            case.failure(let error):
                print(error)
            }
        }
    }
}

//UISearchBarDelegate
extension SearchTableViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        page = 1
        bookData.removeAll()
        bookAPI()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        page = 1
        bookData.removeAll()
        bookAPI()
    }
}

//design
extension SearchTableViewController{
    func designNavigationItem(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButton))
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.titleView = searchBar
        searchBar.placeholder = "검색어를 입력해주세요."
        searchBar.searchTextField.becomeFirstResponder()
        searchBar.setShowsCancelButton(true, animated: true)
    }
}
