//
//  ReviewListPresenterTests.swift
//  ReviewListPresenterTests
//
//  Created by 정유진 on 2022/03/15.
//

import XCTest
@testable import MyBookReview

class ReviewListPresenterTests: XCTestCase {
    var sut: ReviewListPresenter!
    var viewController : MockReviewListViewController!
    var userDefaultManager: MockUserDefaultsManager!
    
    override func setUp() {
        super.setUp()
        viewController = MockReviewListViewController()
        userDefaultManager = MockUserDefaultsManager()
        sut = ReviewListPresenter(
            viewController: viewController,
        userDefaultManager: userDefaultManager)
    }
    
    override func tearDown() {
        sut = nil
        viewController = nil
        userDefaultManager = nil
        super.tearDown()
    }
    
    func test_viewDidLoad() {
        sut.viewDidLoad()
        XCTAssertTrue(viewController.isCalledSetupNavigationBar)
        XCTAssertTrue(viewController.isCalledSetupTableView)
    }
    
    func test_didTapRightBarButtonItem() {
        sut.didTapRightBarButtonItem()
        XCTAssertTrue(viewController.isCalledPresentToRiviewWriteViewController)
    }
    
    func test_viewWillAppear() {
        sut.viewWillAppear()
        XCTAssertTrue(viewController.isCalledReloadTableView)
        XCTAssertTrue(userDefaultManager.isCalledGetReviews)
    }

}



