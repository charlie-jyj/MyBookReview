//
//  SearchBookViewController.swift
//  MyBookReview
//
//  Created by 정유진 on 2022/03/15.
//

import UIKit
import SnapKit

final class SearchBookViewController: UIViewController {
    
    private lazy var presenter = SearchBookPresenter (
        viewController: self,
        delegate: searchBookDelegate)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = presenter
        tableView.delegate = presenter
        return tableView
    }()
    
    private let searchBookDelegate:SearchBookDelegate
    
    init(searchBookDelegate: SearchBookDelegate){
        self.searchBookDelegate = searchBookDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension SearchBookViewController: SearchBookProtocol {
    func setupNavigationBar() {
        view.backgroundColor = .systemBackground
        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
//            barButtonSystemItem: .done,
//            target: self,
//            action: #selector(tapRightBarButtonItem))
        
        let searchBarController = UISearchController(searchResultsController: nil)
        searchBarController.searchBar.placeholder = "책 제목 검색하기"
        searchBarController.obscuresBackgroundDuringPresentation = false
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
    
    func dismiss() {
        // list item을 2번 tap 해야 dismiss 되는 것 방지
        self.navigationController?.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}


private extension SearchBookViewController {
    @objc func tapRightBarButtonItem() {
        presenter.tapRightBarButtonItem()
    }
}
