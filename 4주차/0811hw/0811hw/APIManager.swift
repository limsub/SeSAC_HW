//
//  APIManager.swift
//  0811hw
//
//  Created by 임승섭 on 2023/08/11.
//

import Foundation
import SwiftyJSON
import Alamofire

class APIManager {
    
    static let shared = APIManager()
    private init() {}
    
    let header: HTTPHeaders = ["Authorization" : APIKey.tmdb]
    
    func callRequest(_ type: Endpoint, _ movieID: Int, completionHandler: @escaping (JSON) -> () )  {
        
        var url = type.requestURL
        if (type == .movieDetail) {
            url += "\(movieID)/credits"
        }
        
        AF.request(url, method: .get, headers: header)
            .validate()
            
        
            .responseJSON { response in
                switch response.result {
                case .success(let value) :
                    let json = JSON(value)
                    print("===========")
                    print(json)
                    print("===========")
                    completionHandler(json)

                case .failure(let error) :
                    print(error)
            }

        }
    }
}
