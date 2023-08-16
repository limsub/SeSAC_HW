//
//  EndPoint.swift
//  0816hw
//
//  Created by 임승섭 on 2023/08/16.
//

import Foundation

enum EndPoint {
    case video
    
    var requestURL: String {
        switch self {
        case .video:
            return URL.makeEndPointString("vclip?query=")
        }
    }
}
