//
//  LottoViewController.swift
//  0808hw
//
//  Created by 임승섭 on 2023/08/08.
//

import UIKit
import Alamofire
import SwiftyJSON

class LottoViewController: UIViewController {
    
    @IBOutlet var numberTextField: UITextField!
    
    @IBOutlet var lottoViews: [UIView]!
    @IBOutlet var lottoLabels: [UILabel]!
    
    let pickerView = UIPickerView()
    var list: [Int] = Array(1...1079).reversed()
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for label in lottoLabels {
            label.font = .boldSystemFont(ofSize: 25)
            label.textColor = .white
        }
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        numberTextField.inputView = pickerView
        numberTextField.tintColor = .clear
        

        receiveLotto(1079)
    }
    
    
    func receiveLotto(_ num: Int) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(num)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                for i in 0...5 {
                    self.lottoLabels[i].text = json["drwtNo\(i+1)"].stringValue
                }
                self.lottoLabels[6].text = json["bnusNo"].stringValue
                
                self.changeColor()
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func changeColor(){
        for i in 0...6 {
            
            switch Int(lottoLabels[i].text!)! {
            case 1...10:
                lottoViews[i].backgroundColor = .orange
            case 11...20:
                lottoViews[i].backgroundColor = .blue
            case 21...30:
                lottoViews[i].backgroundColor = .red
            case 31...40:
                lottoViews[i].backgroundColor = .gray
            case 41...45:
                lottoViews[i].backgroundColor = .green
            default :
                break;
            }
            
            
        }
    }



}


extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        numberTextField.text = "\(list[row])회 당첨번호"
        
        receiveLotto(list[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return "\(list[row])회"
    }
}
