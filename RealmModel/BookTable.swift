//
//  BookTable.swift
//  BookShelf
//
//  Created by 김하은 on 2023/09/05.
//

import Foundation
import RealmSwift

class BookTable: Object {
    
    @Persisted(primaryKey: true) var isbn: ObjectId
    @Persisted var thumbnail: String?
    @Persisted var title: String
    @Persisted var contents: String?

    convenience init(thumbnail: String?, title: String, contents: String?) {
        self.init()
        
        self.thumbnail = thumbnail
        self.title = title
        self.contents = contents
    }
}
