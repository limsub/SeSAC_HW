//
//  TmdbAPIManager.swift
//  0818hw
//
//  Created by 임승섭 on 2023/08/18.
//

import Foundation
import Alamofire
import SwiftyJSON

class TmdbAPIManager {
    
    static let shared = TmdbAPIManager()
    private init() {}
        
    let header: HTTPHeaders = ["Authorization" : Key.tmdb]
    
    // TV Detail
    func callSeason(_ seriesId: Int, completionHandler: @escaping (Tv) -> Void ) {
        
        let url = URL.makeSeasonUrl(seriesId)
        
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200...500)
            .responseDecodable(of: Tv.self) { response in
                
                let statusCode = response.response?.statusCode ?? 500
                
                if (statusCode == 200) {
                    guard let value = response.value else { return }
                    completionHandler(value)
                } else {
                    print("Error!! statusCode : \(statusCode)")
                    print(response)
                }
            }
    }
    
    // TV Season Detail
    func callEpisode(_ seriesId: Int, _ season: Int, completionHandler: @escaping (Tvdetail)-> Void) {
        
        let url = URL.makeEpisodeUrl(seriesId, season)
        
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200...500)
            .responseDecodable(of: Tvdetail.self) { response in
                
                let statusCode = response.response?.statusCode ?? 500
                
                if (statusCode == 200) {
                    //print(response)
                    //print("hi")
                    //print(response.value)
                    guard let value = response.value else { return }
                    completionHandler(value)
                } else {
                    print("Error!! statusCode : \(statusCode)")
                    print(response)
                }
            }
    }
    
    
    // TV search
    func callSearch(_ query: String, completionHandler: @escaping (Searching) -> Void) {
        let url = URL.makeSearchingUrl(query)
        
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200...500)
            .responseDecodable(of: Searching.self) { response in
                
                let statusCode = response.response?.statusCode ?? 500
                
                if (statusCode == 200) {
                    guard let value = response.value else { return }
                    completionHandler(value)
                } else {
                    print("Error!! statusCode : \(statusCode)")
                    print(response)
                }
            }
    }
}

