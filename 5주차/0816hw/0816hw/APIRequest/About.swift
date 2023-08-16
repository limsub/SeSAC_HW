//
//  About.swift
//  0816hw
//
//  Created by 임승섭 on 2023/08/16.
//

import Foundation

struct Video: Codable {
    let documents: [Document]
    let meta: Meta
    let ds: [String]
    let m: M
    let g: [String]
}

// MARK: - Document
struct Document: Codable {
    let datetime, title: String
    let playTime: Int
    let thumbnail: String
    let author: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case datetime, title
        case playTime = "play_time"
        case thumbnail, author, url
    }
}

// MARK: - M
struct M: Codable {
}

// MARK: - Meta
struct Meta: Codable {
    let pageableCount: Int
    let isEnd: Bool
    let totalCount: Int

    enum CodingKeys: String, CodingKey {
        case pageableCount = "pageable_count"
        case isEnd = "is_end"
        case totalCount = "total_count"
    }
}
