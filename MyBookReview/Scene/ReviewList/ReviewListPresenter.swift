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
    private let userDefaultManager = UserDefaultManager()
    
    init(viewController: ReviewListProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController.setupNavigationBar()
        viewController.setupTableView()
    }
    
    func viewWillAppear() {
        viewController.reloadTableView()
    }
    
    func didTapRightBarButtonItem() {
        viewController.presentToRiviewWriteViewController()
    }
    
}

extension ReviewListPresenter: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userDefaultManager.getReviews().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let review = userDefaultManager.getReviews()[indexPath.row]
        var content = cell.defaultContentConfiguration()
        
        content.text = "\(review.title)"
        content.secondaryText = "\(review.content)"
        
        if let url = review.imageURL, let data = try? Data(contentsOf: url) {
            content.image = UIImage(data: data)
        }
        cell.contentConfiguration = content
        cell.selectionStyle = .none
        return cell
    }
    
}

