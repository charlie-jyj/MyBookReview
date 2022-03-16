//
//  UserDefaultManager.swift
//  MyBookReview
//
//  Created by 정유진 on 2022/03/16.
//

import Foundation

protocol UserDafaultMangerProtocol {
    func getReviews() -> [Review]
    func setReviews(_ newValue: Review)
}

struct UserDefaultManager: UserDafaultMangerProtocol {
    enum Key: String {
        case reviews
    }
    
    func getReviews() -> [Review] {
        guard let data = UserDefaults.standard.data(forKey: Key.reviews.rawValue) else { return [] }
        return (try? PropertyListDecoder().decode([Review].self, from: data)) ?? []
    }
    
    func setReviews(_ newValue: Review) {
        var currentReviews: [Review] = getReviews()
        currentReviews.insert(newValue, at: 0)
        UserDefaults.standard.setValue(
            try? PropertyListEncoder().encode(currentReviews),
            forKey: Key.reviews.rawValue)
    }
}
