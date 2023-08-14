//
//  DetailViewController.swift
//  0811hw
//
//  Created by 임승섭 on 2023/08/11.
//

import UIKit
import Alamofire
import SwiftyJSON

class DetailViewController: UIViewController {
    
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var backImageView: UIImageView!
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var contentLabel: UILabel!

    
    @IBOutlet var fullBUtton: UIButton!
    
   //@IBOutlet var overTextView: UITextView!
    @IBOutlet var castTextView: UITextView!
    @IBOutlet var crewTextView: UITextView!
    
    
    var isFull = false
    
    var movieID: Int = 0
    var movieName: String = ""
    var overView: String = ""
    
    var mainImageLink: String = ""
    var backImageLink: String = ""
    
    func checkFull() {
        contentLabel.numberOfLines = (isFull) ? 0 : 3
        fullBUtton.setTitle( (isFull) ? "줄이기" : "전체보기", for: .normal)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        checkFull()
        
        //print(movieID)
        
        titleLabel.text = movieName
        //overTextView.text = overView
        contentLabel.text = overView
        
        castTextView.text = ""
        crewTextView.text = ""
        
        //overTextView.isEditable = false
        castTextView.isEditable = false
        crewTextView.isEditable = false
        
        
        let urlMain = URL(string: Endpoint.imagePrefix.requestURL + mainImageLink)
        mainImageView.kf.setImage(with: urlMain)
        
        let urlBack = URL(string: Endpoint.imagePrefix.requestURL + backImageLink)
        backImageView.kf.setImage(with: urlBack)
        backImageView.contentMode = .scaleAspectFill
        
        // 실질적으로 api에서 받아와서 레이블에 써주는건 cast, crew 리스트
        // 나머지는 화면 전환 시 값 전달로 받아옴
        APIManager.shared.callRequest(.movieDetail, movieID) { json in
            for person in json["cast"].arrayValue {
                self.castTextView.text += person["name"].stringValue
                self.castTextView.text += "\n"
            }
            
            for person in json["crew"].arrayValue {
                self.crewTextView.text += person["name"].stringValue
                self.crewTextView.text += "\n"
            }
        }
    }
    
    
    @IBAction func fullButtonTapped(_ sender: UIButton) {
        isFull.toggle()
        
        checkFull()
    }
    
}
