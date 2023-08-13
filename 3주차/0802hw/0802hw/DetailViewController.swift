//
//  DetailViewController.swift
//  0802hw
//
//  Created by 임승섭 on 2023/08/02.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet var mainLabel: UILabel!
    
    var contents: Movie?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let contents {
            title = "\(contents.title)"
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonTapped))

        mainLabel.numberOfLines = 0
        if let contents {
            mainLabel.text = "제목 : \(contents.title)\n출시일 : \(contents.releaseDate)\n평점 : \(contents.rate)\n러닝타임 : \(contents.runtime)\n줄거리 : \(contents.overview)"
        }
    }
    
    @objc
    func closeButtonTapped() {
        dismiss(animated: true)
    }
    
}
