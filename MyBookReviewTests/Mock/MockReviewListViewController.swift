//
//  MockReviewListViewController.swift
//  MyBookReviewTests
//
//  Created by 정유진 on 2022/03/28.
//

import XCTest
@testable import MyBookReview

final class MockReviewListViewController: ReviewListProtocol {
    
    var isCalledSetupNavigationBar = false
    var isCalledSetupTableView = false
    var isCalledPresentToRiviewWriteViewController = false
    var isCalledReloadTableView = false
    
    func setupNavigationBar() {
        isCalledSetupNavigationBar = true
    }
    
    func setupTableView() {
        isCalledSetupTableView = true
    }
    
    func presentToRiviewWriteViewController() {
        isCalledPresentToRiviewWriteViewController = true
    }
    
    func reloadTableView() {
        isCalledReloadTableView = true
    }
}
