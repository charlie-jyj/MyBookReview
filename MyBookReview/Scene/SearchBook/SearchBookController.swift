//
//  SearchBookController.swift
//  MyBookReview
//
//  Created by 정유진 on 2022/03/15.
//

import UIKit

final class SearchBookController: UIViewController {
    
    private lazy var presenter = SearchBookPresenter(viewController: self)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = presenter
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension SearchBookController: SearchBookProtocol {
    func setupNavigationBar() {
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
//            barButtonSystemItem: .done,
//            target: self,
//            action: #selector(tapRightBarButtonItem))
        
        let searchBarController = UISearchController(searchResultsController: nil)
        searchBarController.searchBar.placeholder = "책 제목 검색하기"
        searchBarController.obscuresBackgroundDuringPresentation = true
        searchBarController.searchBar.delegate = presenter
        
        self.navigationItem.searchController = searchBarController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func close() {
        self.dismiss(animated: true, completion: nil)
    }
}

private extension SearchBookController {
    @objc func tapRightBarButtonItem() {
        presenter.tapRightBarButtonItem()
    }
}
