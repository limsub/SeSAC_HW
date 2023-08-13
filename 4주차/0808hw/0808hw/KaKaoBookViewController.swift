//
//  KaKaoBookViewController.swift
//  0808hw
//
//  Created by 임승섭 on 2023/08/08.
//

import UIKit
import SwiftyJSON
import Alamofire
import Kingfisher

class KaKaoBookViewController: UIViewController {

    @IBOutlet var bookTableView: UITableView!
    @IBOutlet var bookSearchBar: UISearchBar!
    
    
    var searchList: [Book] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookTableView.dataSource = self
        bookTableView.delegate = self
        bookTableView.rowHeight = 140

        let nib = UINib(nibName: "KakaoBookTableViewCell", bundle: nil)
        bookTableView.register(nib, forCellReuseIdentifier: "KakaoBookTableViewCell")
        
        // callRequest()
    }
    
    func callRequest(text: String) {
        
        searchList.removeAll()
        
        
        if text.count == 0 {
            print("제로")
            
            bookTableView.reloadData()
            return
        }
        
        guard let txt = "\(text)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        
        let url = "https://dapi.kakao.com/v3/search/book?query=\(txt)"
        
        let header: HTTPHeaders = ["Authorization": "KakaoAK \(APIKey.kakao)"]
        
        AF.request(url, method: .get, headers: header)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value) :
                    let json = JSON(value)
                    //print("JSON: \(json)")
                    
                    for book in json["documents"].arrayValue {
                        
                        let url = URL(string: book["thumbnail"].stringValue)
                        let title = book["title"].stringValue
                        let price = book["price"].intValue
                        let dcPrice = book["sale_price"].intValue
                        let author = book["authors"].stringValue
                        let publisher = book["publisher"].stringValue
                        let story = book["contents"].stringValue
                        
                        self.searchList.append(
                            Book(imageUrl: url, title: title, price: price, dcPrice: dcPrice, author: author, publisher: publisher, story: story, inCart: false)
                        )
                        
                    }
                    
                    self.bookTableView.reloadData()
                    
                    
                    
                case .failure(let error) :
                    print(error)
                }
                
            }
    
    }
    

}



extension KaKaoBookViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bookTableView.dequeueReusableCell(withIdentifier: "KakaoBookTableViewCell") as! KakaoBookTableViewCell
        
        cell.designCell(searchList[indexPath.row])
        
        return cell
    }
}



extension KaKaoBookViewController: UISearchBarDelegate {
    func configureSearchBar() {
            bookSearchBar.delegate = self
            bookSearchBar.placeholder = "검색어를 입력해주세요"
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            guard let text = searchBar.text else { return }
            callRequest(text: text)
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            guard let text = searchBar.text else { return }
            callRequest(text: text)
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
             
            searchBar.text = ""
            callRequest(text: searchBar.text!)
            bookTableView.reloadData()
        }
        
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = true
        }
        
        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = false
        }
    


}
