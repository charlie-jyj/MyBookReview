//
//  SearchBookPresenter.swift
//  MyBookReview
//
//  Created by 정유진 on 2022/03/15.
//

import Foundation
import UIKit

protocol SearchBookProtocol {
    func setupNavigationBar()
    func setupTableView()
    func close()
}

final class SearchBookPresenter: NSObject {
    private let viewController: SearchBookProtocol
    
    init (viewController: SearchBookProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController.setupNavigationBar()
        viewController.setupTableView()
    }
    
    func tapRightBarButtonItem() {
        viewController.close()
    }
}

extension SearchBookPresenter: UITableViewDataSource {
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

extension SearchBookPresenter: UISearchBarDelegate {
    
}
