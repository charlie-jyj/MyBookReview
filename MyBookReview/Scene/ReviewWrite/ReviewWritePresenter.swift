//
//  ReviewWritePresenter.swift
//  MyBookReview
//
//  Created by 정유진 on 2022/03/15.
//

import Foundation

protocol ReviewWriteProtocol {
    func setupNavigationBar()
    func showCloseAlertSheet()
    func dismiss()
    func setupViews()
    func presentToSearchBookViewController()
    func filloutBookInfo(from book:Book)
}

final class ReviewWritePresenter: NSObject {
    private let viewController: ReviewWriteProtocol
    private let userDefaultManger = UserDefaultManager()
    
    init(
        viewController: ReviewWriteProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController.setupNavigationBar()
        viewController.setupViews()
    }
    
    func didTapLeftBarButtonItem() {
        viewController.showCloseAlertSheet()
    }
    
    func didTapRightBarButtonItem(_ review: Review) {
        userDefaultManger.setReviews(review)
        viewController.dismiss()
    }
    
    func touchUpInsideBookTitleButton() {
        viewController.presentToSearchBookViewController()
    }
    
}

extension ReviewWritePresenter: SearchBookDelegate {
    func selectBook(_ book: Book) {
        viewController.filloutBookInfo(from: book)
    }
}


