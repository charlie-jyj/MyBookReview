# 

## 구현

### 1. 기본 개념

#### 아키텍처

1. MVC
   1. Model: 데이터 수정/추가
   2. ViewController: API Request, Reload Views, Setup Layout
   3. 비대한 ViewController 
2. MVP
   1. Model: 데이터 수정, 추가
   2. Presenter: API Request, user action 발생 시 model에 업데이트 요청, model의 변경 사항 발생 시(**completion handler**) viewcontroller에 ui 업데이트 요청(**delegate**)
   3. ViewController: View 수정, 설정, 추가


<img src="https://i.stack.imgur.com/nlBh0.png">


```swift
final class BookReviewPresenter {
   var  model = Model()

   func updateModel() {
      model.update { [weak self] newModel in
         // viewcontroller 에게 새로운 값 표시를 요청
      }
   }
   
}

protocol BookReviewProtocol {
   func updateViews()
}

final class BookReviewPresenter {
   let delegate: BookReviewProtocol // 직접 viewcontroller 에 접근하지 않고 (캡슐화) protocol이 가진 내용만 알고 있음
   init(delegate: BookReviewProtocol) {
      self.delegate = delegate
   }

   func didTapReloadButton() {
      //model에게 요청 후
      delegate.updateViews()
   }
}

final class BookReviewViewController: UIViewController {
   let presenter = BookReviewPresenter(delegate:self)

   @objc func didTapReloadButton() {
      presenter.didTapReloadButton()
   }
}

extension BookReviewViewController: BookReviewProtocol {
   func updateViews() {
      tableView.reloadData()
   }
}
```

### 2. 새롭게 알게 된 것

#### 🤓 delegate pattern 적용된 코드 뜯어보기

1. SearchBookPresenter

```swift
protocol SearchBookDelegate {
    func selectBook(_ book: Book)
}

final class SearchBookPresenter: NSObject {
    private let viewController: SearchBookProtocol
    private let delegate: SearchBookDelegate
    
    ...
    
extension SearchBookPresenter: UITableViewDataSource, UITableViewDelegate {
    ...
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 책 선택 후 객체를 넘긴다.
        self.delegate.selectBook(bookList[indexPath.row])
        viewController.dismiss()
    }
}

```

2. ReviewWritePresenter

```swift

    func touchUpInsideBookTitleButton() {
        viewController.presentToSearchBookViewController()
    }

extension ReviewWritePresenter: SearchBookDelegate {
    func selectBook(_ book: Book) {
        self.book = book
        viewController.filloutBookInfo(from: book)
    }
}

v
```

3. ReviewWriteViewController

```swift
final class ReviewWriteViewController: UIViewController {
    private lazy var presenter:ReviewWritePresenter = ReviewWritePresenter(viewController: self)
    ...
    
    func presentToSearchBookViewController() {
        let viewController = UINavigationController(
            rootViewController: SearchBookViewController(searchBookDelegate: presenter))
        present(viewController, animated: true, completion: nil)
    }

```


- 이벤트(book list selected) 발행의 주체는 SearchBookPresenter
    - delegate protocol을 작성한다
    - var delegate를 가진다
- SearchBookPresenter 역할을 확장 시키는 event listener 는 ReviewWritePresenter
    - delegate protocol을 구현한다
