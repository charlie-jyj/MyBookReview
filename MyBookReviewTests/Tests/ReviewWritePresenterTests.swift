//
//  ReviewWritePresenterTests.swift
//  MyBookReviewTests
//
//  Created by 정유진 on 2022/03/28.
//

import XCTest
@testable import MyBookReview

class ReviewWritePresenterTests: XCTestCase {
    var sut: ReviewWritePresenter!  // system under test
    var viewController : MockReviewWriteViewController!
    var userDefaultManager: MockUserDefaultsManager!
    
    override func setUp() {
        super.setUp()
        viewController = MockReviewWriteViewController()
        userDefaultManager = MockUserDefaultsManager()
        sut = ReviewWritePresenter(
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
        XCTAssertTrue(viewController.isCalledSetupViews)
    }
    
    func test_didTapLeftBarButtonItem() {
        sut.didTapLeftBarButtonItem()
        XCTAssertTrue(viewController.isCalledShowCloseAlertSheet)
    }
    
    func test_didTapRightBarButtonItemWithBookWithContent() {
        sut.book = Book(title: "Swift", imageURL: "www")
        sut.didTapRightBarButtonItem(contentsText: "좋은 책")
        XCTAssertTrue(userDefaultManager.isCalledSetReview)
        XCTAssertTrue(viewController.isCalledDismiss)
    }
    
    func test_didTapRightBarButtonItemWithoutBook() {
        sut.book = nil
        sut.didTapRightBarButtonItem(contentsText: "no book")
        XCTAssertFalse(userDefaultManager.isCalledSetReview)
        XCTAssertFalse(viewController.isCalledDismiss)
    }
    
    func test_didTapRightBarButtonItemWithBookWithoutContent() {
        sut.book = Book(title: "Swift", imageURL: "www")
        sut.didTapRightBarButtonItem(contentsText: nil)
        XCTAssertFalse(userDefaultManager.isCalledSetReview)
        XCTAssertFalse(viewController.isCalledDismiss)
    }
    
    func test_didTapRightBarButtonItemWithBookWithPlaceholder() {
        sut.book = Book(title: "Swift", imageURL: "www")
        sut.didTapRightBarButtonItem(contentsText: sut.placeholder)
        XCTAssertFalse(userDefaultManager.isCalledSetReview)
        XCTAssertFalse(viewController.isCalledDismiss)
    }
    
    func test_touchUpInsideBookTitleButton() {
        sut.touchUpInsideBookTitleButton()
        XCTAssertTrue(viewController.isCalledPresentToSearchBookViewController)
    }
    
}

final class MockReviewWriteViewController: ReviewWriteProtocol {
    var isCalledSetupNavigationBar = false
    var isCalledShowCloseAlertSheet = false
    var isCalledDismiss = false
    var isCalledSetupViews = false
    var isCalledPresentToSearchBookViewController = false
    var isCalledFilloutBookInfo = false
    
    func setupNavigationBar() {
        isCalledSetupNavigationBar = true
    }
    
    func showCloseAlertSheet() {
        isCalledShowCloseAlertSheet = true
    }
    
    func dismiss() {
        isCalledDismiss = true
    }
    
    func setupViews() {
        isCalledSetupViews = true
    }
    
    func presentToSearchBookViewController() {
        isCalledPresentToSearchBookViewController = true
    }
    
    func filloutBookInfo(from book: Book) {
        isCalledFilloutBookInfo = true
    }
    
    
}
