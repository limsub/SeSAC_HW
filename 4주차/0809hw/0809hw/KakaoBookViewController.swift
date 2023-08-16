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


// 필요한 구조체. 레이블에 띄워줄 문구는 연산 프로퍼티로 받아오기
struct Book {
    let authors: String
    let datetime: String
    let price: Int
    let publisher: String
    let salePrice: Int
    let thumbnail: String
    let title: String
    
    var content1: String {  // 제목
        return "\(title)"
    }
    var content2: String {  // 작가 / 출판사
        return "\(authors) | \(publisher)"
    }
    var content3: String {  // 출판일
        return datetime
    }
    var content4: String {  // 할인율 (오랜만에 원가, 정가, 판매금액 계산하네..)
        // 판매가가 -1 이면 절판
        if (salePrice == -1 ) {
            return "절판"
        }
        else {
            let dcPercent = lround( ( (Double(price) - Double(salePrice) ) / Double(price) ) * 100)
            return "\(price) -> \(salePrice) ( \(dcPercent) % 할인 )"
        }
    }
}

// 오른쪽 pull down button에 들어갈 항목. 레이블로 띄워줄 문구는 연산 프로퍼티
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

// 왼쪽 pull down button에 들어갈 항목. 레이블로 띄워줄 문구는 연산 프로퍼티
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
    
    
    var bookList: [Book] = []   // 테이블뷰에 보여줄 Book 목록
    var pageCnt = 1             // 페이지 수. 스크롤할수록 증가 (pagenation)
    var isEnd = false           // 더이상 보여줄 항목이 없을 때
    
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
        
        // 2 - 1. target option (all이면 따로 쿼리 필요 없지만, all 아니면 쿼리 추가)
        var target = ""
        if (targetingOption != .all) {
            target = "&target=\(targetingOption.rawValue)"
        }
        
        // 2 - 2. sort option
        let sort = "&sort=\(sortingOption.rawValue)"
        
        // 3. 최종 url
        let url = "https://dapi.kakao.com/v3/search/book?query=\(txt)&size=10&page=\(pageCnt)\(target)\(sort)"
        
        // 4. header (HTTPHeader 아님!!)
        let header: HTTPHeaders = ["Authorization" : APIKey.kakao]
        
        // SwiftyJSON : Work with Alamofire
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200...500)    // 구체적인 에러 내용을 알기 위해 success 범위 조정
            .responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
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
    
    // pull down button 디자인
    // 1. 현재 선택된 옵션으로 버튼 타이틀 설정
    // 2. 특정 옵션을 사용자가 선택하면
        // 2 - 1. Option 변수 수정
        // 2 - 2. 타이틀 수정
        // 2 - 3. pageCnt 초기화 (1)
        // 2 - 4. 기존 배열(bookList) 초기화
        // 2 - 5. callRequest 호출
    
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
    
    // 셀이 화면에 등장하기 전에 실행. 미리 pageCnt를 올릴지 결정
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        print("===== 프리패치 \(indexPaths) =====")
        
        for indexPath in indexPaths {
            if (bookList.count-1 == indexPath.row &&
                pageCnt < 15 &&
                !isEnd ) {
                pageCnt += 1
                callRequest(searchBar.text!, pageCnt)
            }
        }
    }
    
    // 빠르게 넘기는 셀들은 데이터 필요 없기 때문에 취소
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("===== 취소여 \(indexPaths) =====")
    }
}

extension KakaoBookViewController: UISearchBarDelegate {
    // 검색 실행
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
