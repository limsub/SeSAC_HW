//
//  URL+Extension.swift
//  0811hw
//
//  Created by 임승섭 on 2023/08/11.
//

import Foundation

extension URL {
    
    static let baseURL = "https://api.themoviedb.org/3/"
    
    static func makeEndPointString(_ endpoint: String) -> String {
        return baseURL + endpoint
    }
}

enum Endpoint {
    case movieTrend
    case movieGenre
    case movieDetail
    case imagePrefix
    
    var requestURL: String {
        switch self {
        case .movieTrend :  return URL.makeEndPointString("trending/movie/week?language=en-US")
        case .movieGenre :  return URL.makeEndPointString("genre/movie/list")
        case .movieDetail : return URL.makeEndPointString("movie/") // 뒤에 추가해줘야 함 : "\(movieID)/credits"
        case .imagePrefix : return "https://image.tmdb.org/t/p/w500/"
        }
    }
}
