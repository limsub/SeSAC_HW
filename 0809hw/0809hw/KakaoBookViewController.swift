//
//  KakaoBookViewController.swift
//  0809hw
//
//  Created by 임승섭 on 2023/08/09.
//

import UIKit


// 8/9 과제
// 1. 카카오 책 검색 테이블뷰
// 2. searchBar로 검색 눌러야 테이블뷰 업데이트
// 3. Pagenation -> prefetching
// 4. 쿼리 적용
    // 4 - 1. 검색 정렬 (정확도, 최신순) -> tableView header에 view 넣고 그 안에 pull down button
    // 4 - 2. 검색 제한 (전체, title, publisher, person) -> searchBar 옆에 pull down button

struct Book {
    let authors: String
    let datetime: String
    let price: Int
    let publisher: String
    let salePrice: Int
    let thumbnail: String
    let title: String
    
    var content1: String {
        return "\(title)"
    }
    var content2: String {
        return "\(authors) | \(publisher)"
    }
    var content3: String {
        return "\(datetime)"
    }
    var content4: String {
        
        let dcPercent = lround( ( (Double(price) - Double(salePrice) ) / Double(price) ) * 100)

        return "\(price) -> \(salePrice) ( \(dcPercent) )% 할인"
    }
}



class KakaoBookViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    



}
