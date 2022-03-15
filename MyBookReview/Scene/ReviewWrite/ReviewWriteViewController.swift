//
//  ReviewWriteViewController.swift
//  MyBookReview
//
//  Created by 정유진 on 2022/03/15.
//

import UIKit
import SnapKit

final class ReviewWriteViewController: UIViewController {
    private lazy var presenter:ReviewWritePresenter = ReviewWritePresenter(viewController: self)
    
    private lazy var bookTitleButton: UIButton = {
        let button = UIButton()
        button.setTitle("책 제목", for: .normal)
        button.setTitleColor(UIColor.tertiaryLabel, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = .systemFont(ofSize: 23.0, weight: .bold)
        button.addTarget(self, action: #selector(touchUpInsideBookTitleButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var contentsTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = UIColor.tertiaryLabel
        textView.text = "내용을 입력해주세요."
        textView.font = .systemFont(ofSize: 16.0, weight: .medium)
        
        textView.delegate = self
        return textView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension ReviewWriteViewController: ReviewWriteProtocol {
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(didTapLeftBarButtonItem))
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(didTapRightBarButtonItem))
    }
    
    func showCloseAlertSheet() {
        let alert = UIAlertController(title: "주의!", message: "작성 중인 화면을 닫습니다. (저장X)", preferredStyle: .alert)
        let closeAction = UIAlertAction(
            title: "닫기", style: .destructive) { [weak self] action in
                self?.dismiss(animated: true, completion: nil)
            }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        [closeAction, cancelAction].forEach {
            alert.addAction($0)
        }
        present(alert, animated: true, completion: nil)
    }
    
    func close() {
        dismiss(animated: true, completion: nil)
    }
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        [bookTitleButton, contentsTextView, imageView].forEach {
            view.addSubview($0)
        }
        
        bookTitleButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20.0)
            $0.trailing.equalToSuperview().inset(20.0)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20.0)
        }
        
        contentsTextView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
            $0.top.equalTo(bookTitleButton.snp.bottom).offset(16.0)
        }
        
        imageView.snp.makeConstraints {
            $0.leading.equalTo(bookTitleButton.snp.leading)
            $0.trailing.equalTo(bookTitleButton.snp.trailing)
            $0.top.equalTo(contentsTextView.snp.bottom).offset(16.0)
            $0.height.equalTo(200.0)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func showSearchBookController() {
        let viewController = UINavigationController(rootViewController: SearchBookController())
        present(viewController, animated: true, completion: nil)
    }
}

extension ReviewWriteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == UIColor.tertiaryLabel else { return }
        textView.text = nil
        textView.textColor = UIColor.label
    }
}

private extension ReviewWriteViewController {
    @objc func didTapLeftBarButtonItem() {
        presenter.didTapLeftBarButtonItem()
    }
    
    @objc func didTapRightBarButtonItem() {
        presenter.didTapRightBarButtonItem()
    }
    
    @objc func touchUpInsideBookTitleButton() {
        presenter.touchUpInsideBookTitleButton()
    }
}
