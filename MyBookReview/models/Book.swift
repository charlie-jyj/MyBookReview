//
//  Book.swift
//  MyBookReview
//
//  Created by 정유진 on 2022/03/16.
//

import Foundation

struct Book:Decodable {
    let title: String
    private let image: String?
    
    var imageURL: URL? {
        return URL(string: image ?? "")
    }
    
    init(title: String, imageURL: String?) {
        self.title = title
        self.image = imageURL
    }
}
