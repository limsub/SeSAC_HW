//
//  About.swift
//  0811hw
//
//  Created by 임승섭 on 2023/08/11.
//

import Foundation


struct MovieForMain {
    let id: Int
    let date: String
    var genre: [Int]    // 일단 Int로 저장
    var genreString: [String]   // 장르 코드 가지고 스트링 저장해주자
    let mainImage: String
    let backImage: String
    let rate: Double
    let title: String
    let overview: String
    
}

struct MovieForDetail {
    let id: Int
    let mainImage: String
    let backImage: String
    let title: String
    let overView: String
    let cast: [String]
    let crew: [String]
}

