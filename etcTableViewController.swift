//
//  etcTableViewController.swift
//  BookShelf
//
//  Created by 김하은 on 2023/08/10.
//

import UIKit
import Alamofire
import SwiftyXMLParser
import Kingfisher

class etcTableViewController: UITableViewController {

    var bookData: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: SearchTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: SearchTableViewCell.identifier)
        
        title = "둘러보기"
        tableView.rowHeight = 150
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bookAPI()
    }
}
//Book API
extension etcTableViewController{
    func bookAPI(){
        let url = "https://www.aladin.co.kr/ttb/api/ItemList.aspx?ttbkey=\(APIKey.aladin)&QueryType=Bestseller&MaxResults=50&start=1&SearchTarget=Book&output=xml&Version=20131101"
        
        AF.request(url, method: .get).responseData { response in
            if let data = response.data {
                let xml = XML.parse(data)
                
                for i in 0...49{
                    print(i)
                    self.bookData.append(Book(isbn: nil, thumbnail: xml["object", "item", i, "cover"].text ?? "", title: xml["object", "item", i, "title"].text ?? "", contents: xml["object", "item", i, "description"].text ?? ""))
                }

                self.tableView.reloadData()
            }
        }
    }
}

//tableView
extension etcTableViewController{
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "베스트셀러"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
}
