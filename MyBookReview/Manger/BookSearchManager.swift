//
//  BookSearchManager.swift
//  MyBookReview
//
//  Created by 정유진 on 2022/03/16.
//

import Foundation
import Alamofire

struct BookSearchManager {
    func request(from keyword:String, completionHandler: @escaping (([Book]) -> Void)) {
        guard let url = URL(string: "https://openapi.naver.com/v1/search/book.json") else { return }
        let parameters = BookSearchRequestModel(query: keyword)
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id":"YQSjw8QZ0EcmHaswHOTG",
            "X-Naver-Client-Secret":"eafKYBR9SK"
        ]
        AF
            .request(url, method: .get, parameters: parameters, headers: headers)
            .responseDecodable(of: BookSearchResponseModel.self) { response in
                switch response.result {
                case let .success(data):
                    // case .success(let data) 도 가능 (enumeration doc 참고)
                    completionHandler(data.items)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
            .resume()
       
    }
}
