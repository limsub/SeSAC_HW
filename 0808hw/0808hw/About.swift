//
//  About.swift
//  0808hw
//
//  Created by 임승섭 on 2023/08/08.
//

import UIKit

struct Book {
    var imageUrl: URL?
    var title: String
    var price: Int
    var dcPrice: Int
    var author: String
    var publisher: String
    var story: String
    var inCart: Bool
    
    var percent: Int {
        return lroundl(( (Double(price) - Double(dcPrice))/Double(price) ) * 100)
    }
}
