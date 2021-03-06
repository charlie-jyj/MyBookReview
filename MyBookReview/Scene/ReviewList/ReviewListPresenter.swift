//
//  ReviewListPresenter.swift
//  MyBookReview
//
//  Created by 정유진 on 2022/03/15.
//

import UIKit
import Kingfisher

protocol ReviewListProtocol {
    func setupNavigationBar()
    func setupTableView()
    func presentToRiviewWriteViewController()
    func reloadTableView()
}

protocol ReviewDetailProtocol {
    func showReviewDetail()
}

final class ReviewListPresenter: NSObject {
    private let viewController: ReviewListProtocol
    private var reviewList: [Review] = []
    private let userDefaultManager : UserDefaultManagerProtocol
    
    init(
        viewController: ReviewListProtocol,
        userDefaultManager: UserDefaultManagerProtocol = UserDefaultManager()) {
        self.viewController = viewController
        self.userDefaultManager = userDefaultManager
    }
    
    func viewDidLoad() {
        viewController.setupNavigationBar()
        viewController.setupTableView()
    }
    
    func viewWillAppear() {
        reviewList = userDefaultManager.getReviews()
        viewController.reloadTableView()
    }
    
    func didTapRightBarButtonItem() {
        viewController.presentToRiviewWriteViewController()
    }
    
}

extension ReviewListPresenter: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reviewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let review = reviewList[indexPath.row]
        var content = cell.defaultContentConfiguration()
        
        content.text = "\(review.title)"
        content.secondaryText = "\(review.content)"
        
        if let url = review.imageURL, let data = try? Data(contentsOf: url) {
            content.image = UIImage(data: data)
        }
        cell.contentConfiguration = content
        cell.setNeedsLayout()
        cell.selectionStyle = .none
        return cell
    }
    
}

