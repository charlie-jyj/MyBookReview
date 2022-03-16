//
//  BookSearchResponseModel.swift
//  MyBookReview
//
//  Created by 정유진 on 2022/03/16.
//

import Foundation

struct BookSearchResponseModel:Decodable {
    var items: [Book] = []
}

