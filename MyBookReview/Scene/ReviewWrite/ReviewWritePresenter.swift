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
    func close()
    func setupViews()
    func showSearchBookController()
}

final class ReviewWritePresenter: NSObject {
    private let viewController: ReviewWriteProtocol
    
    init(viewController: ReviewWriteProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController.setupNavigationBar()
        viewController.setupViews()
    }
    
    func didTapLeftBarButtonItem() {
        viewController.showCloseAlertSheet()
    }
    
    func didTapRightBarButtonItem() {
        // user가 작성한 도서 리뷰 저장하기
        viewController.close()
    }
    
    func touchUpInsideBookTitleButton() {
        viewController.showSearchBookController()
    }
    
}
