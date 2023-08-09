//
//  KakaoBookViewController.swift
//  0809hw
//
//  Created by 임승섭 on 2023/08/09.
//

import UIKit
import SwiftyJSON
import Alamofire
import Kingfisher

/* ===== 8/9 과제 =====*/
// 8/9 과제
// 1. 카카오 책 검색 테이블뷰
// 2. searchBar로 검색 눌러야 테이블뷰 업데이트
// 3. Pagenation -> prefetching
// 4. 쿼리 활용
    // 4 - 1. 검색 정렬 (정확도, 최신순) -> tableView header에 view 넣고 그 안에 pull down button
    // 4 - 2. 검색 제한 (전체, title, publisher, person) -> searchBar 옆에 pull down button




/* ===== 할거 =====*/
// tableView Cell 파일 연결
// 프로토콜 채택 - tableview(dele, data, prefetching), searchBar(dele)
    // 함수 선언
    // 연결
// 검색 기능 작동
// pull down button 작동. tableView.reloadData()


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
        return datetime
    }
    var content4: String {
        
        // 판매가가 -1 이면 절판인 듯 하다
        if (salePrice == -1 ) {
            return "절판"
        }
        
        else {
            let dcPercent = lround( ( (Double(price) - Double(salePrice) ) / Double(price) ) * 100)
            
            return "\(price) -> \(salePrice) ( \(dcPercent) % 할인 )"
        }
    }
}

enum sorting: String {
    case accuracy
    case latest
    
    var forMenu: String {
        switch self {
        case .accuracy : return "정확도순"
        case .latest : return "발간일순"
        }
    }
}

enum targeting: String {
    case all
    case title
    case publisher
    case person
    
    var forMenu: String {
        switch self {
        case .all : return "전체"
        case .title : return "제목"
        case .publisher : return "출판사"
        case .person : return "인명"
        }
    }
}



class KakaoBookViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var bookTableView: UITableView!
    
    @IBOutlet var targetPullDownButton: UIButton!
    @IBOutlet var sortPullDownButton: UIButton!
    
    
    var bookList: [Book] = []
    var pageCnt = 1
    var isEnd = false
    
    var sortingOption = sorting.accuracy
    var targetingOption = targeting.all
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        bookTableView.dataSource = self
        bookTableView.delegate = self
        bookTableView.prefetchDataSource = self
        
        bookTableView.rowHeight = 120
        
        designSorting(sortPullDownButton)
        designTargeting(targetPullDownButton)
    }
    
    
    
    func callRequest(_ query: String, _ pageCnt: Int) {
        
        // 1. 검색할 문자열
        guard let txt = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        // 2. target
        // all이 아니면, "target=\(targetingOption.rawValue)" 추가
        var target = ""
        if (targetingOption != .all) {
            target = "&target=\(targetingOption.rawValue)"
        }
        
        
        // 3. sort
        var sort = "&sort=\(sortingOption.rawValue)"
        
        // 최종 url
        let url = "https://dapi.kakao.com/v3/search/book?query=\(txt)&size=10&page=\(pageCnt)\(target)\(sort)"
        
        // header (HTTPHeader 아님!!)
        let header: HTTPHeaders = ["Authorization" : APIKey.kakao]
        
        // SwiftyJSON : Work with Alamofire
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200...500)    // 구체적인 에러 내용을 알기 위해 success 범위 조정
            .responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
                
                let statusCode = response.response?.statusCode ?? 500
                
                // 성공(200)인 경우 작업 시작
                if (statusCode == 200) {
                    self.isEnd = json["meta"]["is_end"].boolValue
                    
                    for book in json["documents"].arrayValue {
                        let authors = book["authors"][0].stringValue
                        let datetime = book["datetime"].stringValue
                        let price = book["price"].intValue
                        let publisher = book["publisher"].stringValue
                        let salePrice = book["sale_price"].intValue
                        let thumbnail = book["thumbnail"].stringValue
                        let title = book["title"].stringValue
                        
                        print(salePrice)
                        
                        let newBook = Book(authors: authors, datetime: datetime, price: price, publisher: publisher, salePrice: salePrice, thumbnail: thumbnail, title: title)
                        
                        self.bookList.append(newBook)
                    }
                    
                    self.bookTableView.reloadData();
                }
                // 성공 못하면 메세지 출력
                else {
                    print("에러났어용")
                    print(json)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func designSorting(_ sender: UIButton) {
        sender.setTitle(sortingOption.forMenu, for: .normal)
        
        let op1 = UIAction(title: sorting.accuracy.forMenu) { _ in
            self.sortingOption = sorting.accuracy
            sender.setTitle(self.sortingOption.forMenu, for: .normal)
            self.pageCnt = 1
            self.bookList.removeAll()
            self.callRequest(self.searchBar.text!, self.pageCnt)
        }
        let op2 = UIAction(title: sorting.latest.forMenu) { _ in
            self.sortingOption = sorting.latest
            sender.setTitle(self.sortingOption.forMenu, for: .normal)
            self.pageCnt = 1
            self.bookList.removeAll()
            self.callRequest(self.searchBar.text!, self.pageCnt)
        }
        
        let buttonMenu = UIMenu(title: "정렬 기준을 고르세요", children: [op1, op2])
        sender.menu = buttonMenu
    }
    func designTargeting(_ sender: UIButton) {
        sender.setTitle(targetingOption.forMenu, for: .normal)
        
        let op1 = UIAction(title: targeting.all.forMenu) { _ in
            self.targetingOption = targeting.all
            sender.setTitle(self.targetingOption.forMenu, for: .normal)
            self.pageCnt = 1
            self.bookList.removeAll()
            self.callRequest(self.searchBar.text!, self.pageCnt)
        }
        let op2 = UIAction(title: targeting.title.forMenu) { _ in
            self.targetingOption = targeting.title
            sender.setTitle(self.targetingOption.forMenu, for: .normal)
            self.pageCnt = 1
            self.bookList.removeAll()
            self.callRequest(self.searchBar.text!, self.pageCnt)
        }
        let op3 = UIAction(title: targeting.publisher.forMenu) { _ in
            self.targetingOption = targeting.publisher
            sender.setTitle(self.targetingOption.forMenu, for: .normal)
            self.pageCnt = 1
            self.bookList.removeAll()
            self.callRequest(self.searchBar.text!, self.pageCnt)
        }
        let op4 = UIAction(title: targeting.person.forMenu) { _ in
            self.targetingOption = targeting.person
            sender.setTitle(self.targetingOption.forMenu, for: .normal)
            self.pageCnt = 1
            self.bookList.removeAll()
            self.callRequest(self.searchBar.text!, self.pageCnt)
        }
        
        let buttonMenu = UIMenu(title: "검색 필드를 고르세요", children: [op1, op2, op3, op4])
        sender.menu = buttonMenu
    }
}

extension KakaoBookViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KakaoBookTableViewCell") as! KakaoBookTableViewCell
        
        // cell 내용
        if let url = URL(string: bookList[indexPath.row].thumbnail) {
            cell.mainImageView.kf.setImage(with: url)
        }
        cell.firstLabel.text = bookList[indexPath.row].content1
        cell.secondLabel.text = bookList[indexPath.row].content2
        cell.thirdLabel.text = bookList[indexPath.row].content3
        cell.fourthLabel.text = bookList[indexPath.row].content4
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if (bookList.count-1 == indexPath.row &&
                pageCnt < 15 &&
                !isEnd ) {
                pageCnt += 1
                callRequest(searchBar.text!, pageCnt)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("===== 취소여 \(indexPaths) =====")
    }
    
    
}

extension KakaoBookViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        pageCnt = 1
        bookList.removeAll()
        
        guard let query = searchBar.text else {return }
        
        // 빈 문자열이면 그냥 테이블뷰만 리로드
        if query == "" {
            bookTableView.reloadData()
        }
        else {
            callRequest(searchBar.text!, pageCnt)
        }
    }
}
