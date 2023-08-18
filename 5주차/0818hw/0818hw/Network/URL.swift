//
//  URL.swift
//  0818hw
//
//  Created by 임승섭 on 2023/08/18.
//

import Foundation


extension URL {
    // image는 URL
    static let imageURL = "https://image.tmdb.org/t/p/w600_and_h900_bestv2"
    
    static func makeImageUrl(_ endpoint: String) -> URL {
        guard let url = URL(string: imageURL + endpoint) else { return URL(string: "")! }
        return url
    }
    
    
    // api는 String
    static let baseUrl = "https://api.themoviedb.org/3/tv/"
    
    static func makeSeasonUrl(_ seriesId: Int) -> String {
        return baseUrl + "\(seriesId)?language=ko-KO"
    }
    
    static func makeEpisodeUrl(_ seriesId: Int, _ season: Int) -> String {
        return baseUrl + "\(seriesId)/season/\(season)?language=ko-KO"
    }
}
