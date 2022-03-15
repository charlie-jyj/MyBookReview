//
//  ReviewListPresenter.swift
//  MyBookReview
//
//  Created by 정유진 on 2022/03/15.
//

import UIKit

protocol ReviewListProtocol {
    func setupNavigationBar()
    func setupTableView()
    func presentToRiviewWriteViewController()
    func reloadTableView()
}

final class ReviewListPresenter: NSObject {
    private let viewController: ReviewListProtocol
    
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

extension ReviewListPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        var content = cell.defaultContentConfiguration()
        content.text = "\(indexPath.row)"
        content.secondaryText = "secondary text"
        cell.contentConfiguration = content
        return cell
    }
    
    
}
