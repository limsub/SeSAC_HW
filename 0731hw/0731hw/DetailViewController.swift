
//  DetailViewController.swift
//  0731hw
//
//  Created by 임승섭 on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {

    var content: String = ""
    
    var aboutMovie: Movie = Movie(title: "", releaseDate: "", runtime: 0, overview: "", rate: 0, like: false)
    
    
    
    @IBOutlet var aboutMovieLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = content
        
//        // 뒤로가기 버튼 커스텀
//        self.navigationController?.navigationBar.topItem?.title = ""
//        self.navigationController?.navigationBar.tintColor = .black
        
        aboutMovieLabel.numberOfLines = 0
        aboutMovieLabel.text = "제목 : \(aboutMovie.title)\n\n개봉일 : \(aboutMovie.releaseDate)\n\n런타임 : \(String(aboutMovie.runtime))\n\n줄거리 : \(aboutMovie.overview)\n\n평점 : \(String(aboutMovie.rate))"
    }
}
