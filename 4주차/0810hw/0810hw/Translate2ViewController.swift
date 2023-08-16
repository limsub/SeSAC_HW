//
//  Translate2ViewController.swift
//  0810hw
//
//  Created by 임승섭 on 2023/08/10.
//

import UIKit
import SwiftyJSON
import Alamofire


class Translate2ViewController: UIViewController {
    
    
    @IBOutlet var firstTextField: UITextField!
    @IBOutlet var secondTextField: UITextField!
    @IBOutlet var firstTextView: UITextView!
    @IBOutlet var secondTextView: UITextView!
    @IBOutlet var translateButton: UIButton!
    
    let firstPickerView = UIPickerView()
    let secondPickerView = UIPickerView()
    
    // 레이블에 띄워줄 문구: api 쿼리
    let dict = [
        "Korean": "ko",
        "English": "en",
        "Japanese": "ja",
        "Chinese - CN": "zh-CN",
        "Chinese - TW": "zh-TW",
        "Vietnam": "vi",
        "Indonesia": "id",
        "Thailand": "th",
        "German": "de",
        "Russian": "ru",
        "Spanish": "es",
        "Italy": "it",
        "Franch": "fr"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        design(firstTextField)
        design(secondTextField)
        design(firstTextView)
        design(secondTextView)
        design(translateButton)
        
        translateButton.setTitle("Translate!", for: .normal)
        
        firstPickerView.delegate = self
        firstPickerView.dataSource = self
        secondPickerView.delegate = self
        secondPickerView.dataSource = self
        
        firstTextField.inputView = firstPickerView
        secondTextField.inputView = secondPickerView
        
        firstTextField.placeholder = "언어를 선택하세요"
        secondTextField.placeholder = "언어를 선택하세요"
        
        firstTextView.text = ""
        secondTextView.text = ""
        secondTextView.isEditable = false
    }
    
    func design(_ sender: UIView) {
        sender.layer.borderWidth = 1
    }
    
    
    
    @IBAction func tranlateButtonTapped(_ sender: UIButton) {
        if ( firstTextField.text == "" || secondTextField.text == "") {
            return;
        }
        
        
        // 최종 url
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        
        // header (HTTPHeader 아님!!)
        let header: HTTPHeaders = [
            "X-Naver-Client-Id" : APIKey.naver,
            "X-Naver-Client-Secret" : APIKey.naverSecret
        ]
        
        let parameter: Parameters = [
            "source": dict[firstTextField.text!]!,
            "target": dict[secondTextField.text!]!,
            "text": firstTextView.text!
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
    
    
    @IBAction func tapgesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}


extension Translate2ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        dict.keys.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == firstPickerView) {
            firstTextField.text = String( Array(dict.keys)[row] )
        } else {
            secondTextField.text = String( Array(dict.keys)[row] )
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String( Array(dict.keys)[row] )
    }
}
