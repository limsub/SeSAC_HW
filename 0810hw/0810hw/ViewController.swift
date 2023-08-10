//
//  ViewController.swift
//  0810hw
//
//  Created by 임승섭 on 2023/08/10.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    
    @IBOutlet var firstTextView: UITextView!
    @IBOutlet var secondTextView: UITextView!
    @IBOutlet var translateButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 디자인
        firstTextView.layer.borderWidth = 1
        firstTextView.text = ""
        secondTextView.layer.borderWidth = 1
        secondTextView.text = ""
        translateButton.layer.borderWidth = 1
        translateButton.setTitle("번역", for: .normal)
    }
    
    
    
    @IBAction func translateButtonTapped(_ sender: UIButton) {
        translate()
    }
    
    @IBAction func tapgesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    
    func translate() {
        // 최종 url
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        
        // header (HTTPHeader 아님!!)
        let header: HTTPHeaders = [
            "X-Naver-Client-Id" : APIKey.naver,
            "X-Naver-Client-Secret" : APIKey.naverSecret
        ]
        
        guard let txt = firstTextView.text else { return }
        
        // parameter
        let parameter: Parameters = [
            "source": "ko",
            "target": "en",
            "text": txt
        ]
        
        // SwiftyJSON : Work with Alamofire
        AF.request(url, method: .post, parameters: parameter, headers: header)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("JSON: \(json)")
                    
                    self.secondTextView.text = json["message"]["result"]["translatedText"].stringValue
                case .failure(let error):
                    print(error)
                }
            }

    }

}

