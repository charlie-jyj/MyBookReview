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
