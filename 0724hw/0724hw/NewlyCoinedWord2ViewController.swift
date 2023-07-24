//
//  NewlyCoinedWord2ViewController.swift
//  0724hw
//
//  Created by 임승섭 on 2023/07/24.
//

import UIKit

class NewlyCoinedWord2ViewController: UIViewController {
    
    var wordDict = [
        "뉴진스" : "새 청바지",
        "알잘딱깔센" : "알아서 잘 딱 깔끔하게 센스있게",
        "별다줄" :"별걸 다 줄인다",
        "억텐" : "억지 텐션의 줄임말. 억지로 텐션을 올려서 발랄하게 행동할 때",
        "스불재" : "스스로 불러온 배앙의 줄임말. 자신이 계획한 일로 자신이 고통을 받을 때 씀",
        "좋댓구알" : "좋아요, 댓글, 구독, 알림 설정",
        "어쩔티비" : "어쩌라고 가서 티비나 봐",
        "갓생" : "갓(God) + 생. 부지런하고 열심히 사는 사람에게 쓰는 말",
        "점메추" : "점심 메뉴 추천"
    ]
    
    
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    
    @IBOutlet var tagButton1: UIButton!
    @IBOutlet var tagButton2: UIButton!
    @IBOutlet var tagButton3: UIButton!
    @IBOutlet var tagButton4: UIButton!
    
    
    
    @IBOutlet var meaningLabel: UILabel!
    @IBOutlet var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundImage.image = UIImage(named: "word_logo")
        backgroundImage.contentMode = .scaleAspectFill

        
        // 디자인
        designSearchTextField(searchTextField)
        designTagButton(tagButton1, "뉴진스")
        designTagButton(tagButton2, "알잘딱깔센")
        designTagButton(tagButton3, "별다줄")
        designTagButton(tagButton4, "억텐")
        designSearchButton(searchButton)
        designMeaningLabel(meaningLabel)
       
    }
    
    
    /* ==== 디자인 함수 ==== */
    // search textfield 디자인
    func designSearchTextField(_ field: UITextField) {
        field.placeholder = "신조어를 입력하세요"
        field.layer.borderColor = UIColor.black.cgColor
        field.layer.borderWidth = 2
    }
    
    // search button 디자인
    func designSearchButton(_ button: UIButton) {
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2
        button.setTitle(nil, for: .normal)
    }
    
    // tag button 디자인
    func designTagButton(_ button: UIButton, _ name: String) {
        
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.setTitle(name, for: .normal)
        button.setTitleColor(.black, for: .normal)
    }
    
    // meaning label 디자인
    func designMeaningLabel(_ label: UILabel) {
        label.textAlignment = .center
        label.numberOfLines = 0
    }
    
    
    /* ==== 기능 함수 ==== */
    func randomTagButton() {
        
        // 딕셔너리에서 단어만 랜덤으로 4개 꺼낸다 (겹치지 않게)
        let keys = wordDict.keys
        var randomKeys: [String] = []
        
        for i in keys {
            randomKeys.append(i)
        }
        randomKeys.shuffle()
        
        // 버튼 텍스트 교체
        
        tagButton1.setTitle(randomKeys[0], for: .normal)
        tagButton2.setTitle(randomKeys[1], for: .normal)
        tagButton3.setTitle(randomKeys[2], for: .normal)
        tagButton4.setTitle(randomKeys[3], for: .normal)
        
    }
    
    func showAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        present(alert, animated: true)
        
        backgroundImage.image = UIImage(named: "word_logo")
        meaningLabel.text = ""
    }
    
    func showMeaning() {
        // 0. image 변경
        backgroundImage.image = UIImage(named: "background")
        
        
        // 1. textfield에 있는 걸 읽는다 (Optional)
        let txt = searchTextField.text
        
        // 2. optional binding
        if let txt {
            
            // 3. 한 글자이거나 빈칸이면 바로 탈락
            if txt.count <= 1 {
                showAlert(title: "글자 수가 부족합니다", message: "다시 입력해주세요")
                
            }
            
            else {
                // 4. 딕셔너리에서 찾는다
                let meaning = wordDict[txt]
                
                // 5 - 1. 딕셔너리에 있으면 화면에 출력
                if meaning != nil {
                    meaningLabel.text = meaning
                }
                
                // 5 - 2. 없으면 탈락
                else {
                    showAlert(title: "뜻이 없는 단어입니다", message: "다시 입력해주세요")
                    
                }
                
                
            }
        }
    }
    
    
    
    @IBAction func keyboardReturnTapped(_ sender: UITextField) {
        showMeaning()
        randomTagButton()
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        showMeaning()
        randomTagButton()
    }
    
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    @IBAction func tagButtonTapped(_ sender: UIButton) {
        // 1. textfield에 적히게
        searchTextField.text = sender.currentTitle
        
        // 2. 그대로 검색 (showMeaning)
        showMeaning()
    }
    
    
}
