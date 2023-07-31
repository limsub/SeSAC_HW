//
//  SearchViewController.swift
//  0731hw
//
//  Created by 임승섭 on 2023/07/31.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "검색 화면"
        
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .plain,
            target: self,
            action: #selector(closeButtonTapped)
        )
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc
    func closeButtonTapped() {
        dismiss(animated: true)     // present로 왔기 때문에 dismiss
    }
    

}
