//
//  APIManager.swift
//  0816hw
//
//  Created by 임승섭 on 2023/08/16.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIManager {
    
    static let shared = APIManager()
    private init() {}
    
    let header: HTTPHeaders = ["Authorization": APIKey.kakaoKey]
    
    
    func callRequest(type: EndPoint, query: String, completionHandler: @escaping (Video) -> () ) {
        
        guard let txt = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        let url = type.requestURL + txt;
        
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200...500)
            .responseDecodable(of: Video.self) { response in
                
                
                let statusCode = response.response?.statusCode ?? 500
                
                
                if (statusCode == 200) {
                    guard let value = response.value else { return }
                    completionHandler(value)
                } else {
                    print("ERROR!")
                    print("statusCode: \(statusCode)")
                    print(response)
                }
            }
    }
    
    
}
