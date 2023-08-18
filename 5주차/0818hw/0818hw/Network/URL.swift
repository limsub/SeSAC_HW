//
//  URL.swift
//  0818hw
//
//  Created by 임승섭 on 2023/08/18.
//

import Foundation


extension URL {
    
    // image url (type: URL)
    static let imageURL = "https://image.tmdb.org/t/p/w600_and_h900_bestv2"
    
    static func makeImageUrl(_ endpoint: String) -> URL {
        guard let url = URL(string: imageURL + endpoint) else { return URL(string: "")! }
        return url
    }
    
    
    // API url (type: String)
    static let baseUrl = "https://api.themoviedb.org/3/tv/"
    
    static func makeSeasonUrl(_ seriesId: Int) -> String {  // TV Series Details (series_id 필요)
        return baseUrl + "\(seriesId)?language=ko-KO"
    }
    
    static func makeEpisodeUrl(_ seriesId: Int, _ season: Int) -> String {  // TV Seasons Details (series_id, season_number 필요)
        return baseUrl + "\(seriesId)/season/\(season)?language=ko-KO"
    }
    
    static func makeSearchingUrl(_ query: String) -> String {   // SearchTV (검색 텍스트 필요)
        guard let txt = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return ""}
        
        return "https://api.themoviedb.org/3/search/tv?query=" + txt
    }
    
}
