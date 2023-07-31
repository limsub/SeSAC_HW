
//  DetailViewController.swift
//  0731hw
//
//  Created by 임승섭 on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {

    var content: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = content
        
//        // 뒤로가기 버튼 커스텀
//        self.navigationController?.navigationBar.topItem?.title = ""
//        self.navigationController?.navigationBar.tintColor = .black
    }
}
