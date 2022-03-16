//
//  BookSearchRequestModel.swift
//  MyBookReview
//
//  Created by 정유진 on 2022/03/16.
//

import Foundation

struct BookSearchRequestModel: Codable {
    /// 검색할 책 키워드
    let query:String
}
