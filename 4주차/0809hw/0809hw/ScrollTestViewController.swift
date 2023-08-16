//
//  ScrollTestViewController.swift
//  0809hw
//
//  Created by 임승섭 on 2023/08/09.
//

import UIKit

class ScrollTestViewController: UIViewController {

    @IBOutlet var mainTableView: UITableView!
    
    var count = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
}

extension ScrollTestViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScrollTestTableViewCell") as! ScrollTestTableViewCell
            
        cell.mainLabel.text = "\(indexPath.row)"
        return cell
    }
}

extension ScrollTestViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if (scrollView.contentSize.height - scrollView.contentOffset.y < 1000) {
            print("=============== 카운트 증가!! ===============")
            count += 100
            mainTableView.reloadData()
        }
        
        print(scrollView.contentSize.height, scrollView.contentOffset.y)
    }
}
