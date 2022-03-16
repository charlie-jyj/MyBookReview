//
//  Review.swift
//  MyBookReview
//
//  Created by 정유진 on 2022/03/16.
//

import Foundation

struct Review: Codable {
    let title: String
    let content: String
    let imageURL: URL?
}
