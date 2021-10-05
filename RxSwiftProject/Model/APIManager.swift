//
//  APIManager.swift
//  RxSwiftProject
//
//  Created by Nitin Gohel on 01/10/21.
//

import UIKit
import Alamofire

enum RequestType: String {
    case login = "login"
}

class APIManager: NSObject {
    static let shared = APIManager()
    static let baseURL = "http://imaginato.mocklab.io/"
    
    func makeRequest(_ request: RequestType, _ httpMethod: HTTPMethod, _ parameters: [String: Any], _ completionHandler: (([String: Any]?, Error?) -> Void)?) {
        let url = APIManager.baseURL + request.rawValue
        AF.request(url, method: httpMethod, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            DispatchQueue.main.async {
                switch response.result {
                case .success:
                    completionHandler?(response.value as? [String: Any], nil)
                    break
                case let .failure(error):
                    completionHandler?(nil, error)
                    break
                }
            }
        }
    }
    
    func login(_ email: String, _ password: String, _ completionHandler: (([String: Any]?, Error?) -> Void)?) {
        let param = ["email": email, "password":password]
        self.makeRequest(.login, .post, param, completionHandler)
    }
}
