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
    
    @IBOutlet var overTextView: UITextView!
    @IBOutlet var castTextView: UITextView!
    @IBOutlet var crewTextView: UITextView!
    
    
    var movieID: Int = 0
    var movieName: String = ""
    var overView: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(movieID)
        
        titleLabel.text = movieName
        overTextView.text = overView
        
        castTextView.text = ""
        crewTextView.text = ""
        
        
        
        // 최종 url
        let url = "https://api.themoviedb.org/3/movie/\(movieID)/credits"
        
        // header (HTTPHeader 아님!!)
        let header: HTTPHeaders = ["Authorization" : APIKey.tmdb]
        
        // SwiftyJSON : Work with Alamofire
        AF.request(url, method: .get, headers: header)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("JSON: \(json)")
                    
                    
                    
                    for person in json["cast"].arrayValue {
                        self.castTextView.text += person["name"].stringValue
                        self.castTextView.text += "\n"
                    }
                    
                    for person in json["crew"].arrayValue {
                        self.crewTextView.text += person["name"].stringValue
                        self.crewTextView.text += "\n"
                    }
                    
                    
                    
                    
                case .failure(let error):
                    print(error)
                }
            }

        
    }

}
