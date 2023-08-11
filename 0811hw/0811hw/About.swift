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
    let genre: [Int]    // 일단 Int로 저장
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
