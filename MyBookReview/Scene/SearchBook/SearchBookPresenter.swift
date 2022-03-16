//
//  SearchBookPresenter.swift
//  MyBookReview
//
//  Created by 정유진 on 2022/03/15.
//

import UIKit

protocol SearchBookProtocol {
    func setupNavigationBar()
    func setupTableView()
    func dismiss()
    func reloadData()
}

protocol SearchBookDelegate {
    func selectBook(_ book: Book)
}

final class SearchBookPresenter: NSObject {
    private let viewController: SearchBookProtocol
    private let delegate: SearchBookDelegate
    private let bookSearchManger = BookSearchManager()
    private var bookList: [Book] = []
    
    init (
        viewController: SearchBookProtocol,
        delegate: SearchBookDelegate) {
            self.viewController = viewController
            self.delegate = delegate
    }
    
    func viewDidLoad() {
        viewController.setupNavigationBar()
        viewController.setupTableView()
    }
    
    func tapRightBarButtonItem() {
        viewController.dismiss()
    }
}

extension SearchBookPresenter: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        var content = cell.defaultContentConfiguration()
        content.text = "\(bookList[indexPath.row].title)"
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 책 선택 후 객체를 넘긴다.
        self.delegate.selectBook(bookList[indexPath.row])
        viewController.dismiss()
    }
}

extension SearchBookPresenter: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        bookSearchManger.request(from: searchText) { [weak self] books in
            self?.bookList = books
            self?.viewController.reloadData()
            
        }
    }
}
