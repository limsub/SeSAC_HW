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
                    completionHandler(json)
                    
                case .failure(let error) :
                    print(error)
            }
            
        }
    }
    
    
    
    
    
//    // 최종 url
//    let url = "https://api.themoviedb.org/3/movie/\(movieID)/credits"
//    
//    // header (HTTPHeader 아님!!)
//    let header: HTTPHeaders = ["Authorization" : APIKey.tmdb]
//    
//    // SwiftyJSON : Work with Alamofire
//    AF.request(url, method: .get, headers: header)
//        .validate()
//        .responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                print("JSON: \(json)")
//                
//                
//                
//                for person in json["cast"].arrayValue {
//                    self.castTextView.text += person["name"].stringValue
//                    self.castTextView.text += "\n"
//                }
//                
//                for person in json["crew"].arrayValue {
//                    self.crewTextView.text += person["name"].stringValue
//                    self.crewTextView.text += "\n"
//                }
//                
//                
//                
//                
//            case .failure(let error):
//                print(error)
//            }
//        }
    
    
    
    
    
    
//    let url = "https://api.themoviedb.org/3/genre/movie/list"
//    
//    let header: HTTPHeaders = ["Authorization" : APIKey.tmdb]
//    
//    
//    // SwiftyJSON : Work with Alamofire
//    AF.request(url, method: .get, headers: header)
//        .validate()
//        .responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                print("JSON22: \(json)")
//                
//                
//                // 3중 loop...?
//                for (index, movie) in self.movieList.enumerated() {
//                    print(index, movie.genre)
//                    self.movieList[index].genreString.removeAll()
//                    
//                    for movieGenre in movie.genre {
//                        
//                        for g in json["genres"].arrayValue {
//                            
//                            if g["id"].intValue == movieGenre {
//                                self.movieList[index].genreString.append(g["name"].stringValue)
//                            }
//                            print(index, self.movieList[index].genreString)
//                        }
//                    }
//                }
//                
//                self.mainTableView.reloadData()
//                
//                
//                
//                
//            case .failure(let error):
//                print(error)
//            }
//        }
    
    
    
//    // 최종 url
//    let url = "https://api.themoviedb.org/3/trending/movie/week?language=en-US"
//    
//    // header (HTTPHeader 아님!!)
//    let header: HTTPHeaders = ["Authorization" : APIKey.tmdb]
//    
//    // SwiftyJSON : Work with Alamofire
//    AF.request(url, method: .get, headers: header)
//        .validate()
//        .responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                //print("JSON: \(json)")
//                
//                for item in json["results"].arrayValue {
//                    print(item)
//                    
//                    let date = item["release_date"].stringValue
//                    // let genre = item["genre_ids"].arrayValue // 일단 스트링으로
//                    var genre: [Int] = []
//                    for g in item["genre_ids"].arrayValue {
//                        genre.append(g.intValue)
//                    }
//                    
//                    let mainImage = item["poster_path"].stringValue
//                    let backImage = item["backdrop_path"].stringValue   // 일단 이건 어떻게 하는건지 모르겠음 지금
//                    let rate = item["vote_average"].doubleValue
//                    let title = item["title"].stringValue
//                    
//                    let id = item["id"].intValue
//                    let overView = item["overview"].stringValue
//                    
//                    let newMovie = MovieForMain(id: id, date: date, genre: genre, genreString: [], mainImage: mainImage, backImage: backImage, rate: rate, title: title, overview: overView)
//                    
//                    self.movieList.append(newMovie)
//                }
//                
//                completion()
//                //print(self.movieList)
//                self.mainTableView.reloadData()
//                
//                
//                
//            case .failure(let error):
//                print(error)
//            }
//    }
    
}
