
//  DetailViewController.swift
//  0731hw
//
//  Created by 임승섭 on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController, UITextViewDelegate {

    var content: String = ""
    
    var aboutMovie: Movie = Movie(title: "", releaseDate: "", runtime: 0, overview: "", rate: 0, like: false, backColor : MovieInfo.randomColor())
    
    let placeholderText = "내용을 입력해주세요"
    
    @IBOutlet var contentTextView: UITextView!
    @IBOutlet var aboutMovieLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentTextView.delegate = self

        title = content
        
//        // 뒤로가기 버튼 커스텀
//        self.navigationController?.navigationBar.topItem?.title = ""
//        self.navigationController?.navigationBar.tintColor = .black
        
        aboutMovieLabel.numberOfLines = 0
        aboutMovieLabel.text = "제목 : \(aboutMovie.title)\n\n개봉일 : \(aboutMovie.releaseDate)\n\n런타임 : \(String(aboutMovie.runtime))\n\n줄거리 : \(aboutMovie.overview)\n\n평점 : \(String(aboutMovie.rate))"
        
        if contentTextView.text.isEmpty {
            contentTextView.text = placeholderText
            contentTextView.textColor = .systemGray5
        }
    }
    
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderText {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholderText
            textView.textColor = .systemGray5
        }
    }
}
