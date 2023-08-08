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
    
    var searchList: [Book] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "KakaoBookTableViewCell", bundle: nil)
        bookTableView.register(nib, forCellReuseIdentifier: "KakaoBookTableViewCell")
    }
    
    func callRequest() {
        
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
