//
//  MockUserDefaultManager.swift
//  MyBookReviewTests
//
//  Created by 정유진 on 2022/03/28.
//

import XCTest
@testable import MyBookReview

final class MockUserDefaultsManager: UserDefaultManagerProtocol {
    var isCalledGetReviews = false
    var isCalledSetReview = false
    
    func getReviews() -> [Review] {
        isCalledGetReviews = true
        return []
    }
    
    func setReviews(_ newValue: Review) {
        isCalledSetReview = true
    }
    
    
}
