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
    private let userDefaultManager: UserDefaultManagerProtocol
    var book: Book?
    var placeholder: String = "내용을 입력해주세요."
    
    init(
        viewController: ReviewWriteProtocol,
        userDefaultManager: UserDefaultManagerProtocol = UserDefaultManager())
    {
        self.viewController = viewController
        self.userDefaultManager = userDefaultManager
    }
    
    func viewDidLoad() {
        viewController.setupNavigationBar()
        viewController.setupViews()
    }
    
    func didTapLeftBarButtonItem() {
        viewController.showCloseAlertSheet()
    }
    
    func didTapRightBarButtonItem(contentsText: String?) {
        guard
            let book = book,
            let contentsText = contentsText, 
            contentsText != placeholder
        else { return }

        let bookReview = Review(
            title: book.title,
            content: contentsText,
            imageURL: book.imageURL
        )
        userDefaultManager.setReviews(bookReview)
        viewController.dismiss()
    }
    
    func touchUpInsideBookTitleButton() {
        viewController.presentToSearchBookViewController()
    }
    
}

extension ReviewWritePresenter: SearchBookDelegate {
    func selectBook(_ book: Book) {
        self.book = book
        viewController.filloutBookInfo(from: book)
    }
}


