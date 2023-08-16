//
//  URL+Extension.swift
//  0816hw
//
//  Created by 임승섭 on 2023/08/16.
//

import Foundation

extension URL {
    static let baseURL = "https://dapi.kakao.com/v2/search/"
    
    static func makeEndPointString(_ endpoint: String) -> String {
        return baseURL + endpoint
    }
}
