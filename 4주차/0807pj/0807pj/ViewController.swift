//
//  ViewController.swift
//  0807sesac
//
//  Created by 임승섭 on 2023/08/07.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class ViewController: UIViewController {
    

    @IBOutlet var beerImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var updateButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.numberOfLines = 0
        descriptionLabel.numberOfLines = 0
    
        callRequest()
    }
    
    @IBAction func updateButtonTapped(_ sender: UIButton) {
        callRequest()
    }
    
    
    func callRequest() {
        
        let url = "https://api.punkapi.com/v2/beers/random"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let url = URL(string: json[0]["image_url"].stringValue)
                
                
                if let url {
                    self.beerImageView.kf.setImage(with: url)
                } else {
                    self.beerImageView.image = UIImage(systemName: "x.square")
                }
                self.nameLabel.text = "name : " + json[0]["name"].stringValue
                self.descriptionLabel.text = "descripption : " + json[0]["description"].stringValue
                
                
            case .failure(let error):
                print(error)
            }
        }
        
    }


}

