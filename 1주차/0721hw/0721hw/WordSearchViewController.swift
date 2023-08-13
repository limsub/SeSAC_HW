//
//  WordSearchViewController.swift
//  0721hw
//
//  Created by 임승섭 on 2023/07/21.
//

// DatePicker / Netflix / Netflix SignUp / Action Sheet / Button Configuration / D-day Counter / Newly Coined Word Search

import UIKit

class WordSearchViewController: UIViewController {

    // 신조어와 뜻을 dictionary로 저장
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
    
    
    // 아웃렛
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
        
        // 디자인
        designSearchTextField(searchTextField)
        designTagButton(tagButton1, "뉴진스")
        designTagButton(tagButton2, "알잘딱깔센")
        designTagButton(tagButton3, "별다줄")
        designTagButton(tagButton4, "억텐")
        designSearchButton(searchButton)
        designMeaningLabel(meaningLabel)
        
        // 아무것도 검색하지 않았을 때 이미지
        backgroundImage.image = UIImage(named: "word_logo")
        backgroundImage.contentMode = .scaleAspectFill
    }

    /*======= 디자인 함수 =======*/
    // search textfield 디자인
    func designSearchTextField(_ field: UITextField) {
        field.placeholder = "신조어를 입력하세요"
        field.layer.borderColor = UIColor.black.cgColor
        field.layer.borderWidth = 2
    }
    
    // search button 디자인
    func designSearchButton(_ button: UIButton) {
        
        // 1. configuration 방법
//        var config = UIButton.Configuration.filled()
//        config.image = UIImage(systemName: "pencil")
//        config.baseBackgroundColor = .black
//        config.baseForegroundColor = .white
//        button.configuration = config
        // 문제 : 모서리가 둥글게 됨
        // 해결 : config.background.cornerRadius = 0 써주면 되더라
        
        // 2. 그냥 정통 방법
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2
        button.setTitle(nil, for: .normal)
        
    }
    
    // tag button 디자인
    func designTagButton(_ button: UIButton, _ name: String) {
        
        // 오토레이아웃으로 서로 여백만 주었는데도 String 길이에 따라 버튼의 사이즈가 자동으로 조절된다
        
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
    
    
    
    /*======= 기능 함수 =======*/
    // 현재 textfield에 있는 단어를 검색해서 화면에 나타나게 하는 함수
    // 키보드의 엔터 키를 누르거나 search Button을 눌렀을 때 실행되게 한다
    func showMeaning() {
        // 0. image 변경
        backgroundImage.image = UIImage(named: "background")
        
        
        // 1. textfield에 있는 걸 읽어옴
        let txt = searchTextField.text!
        
        // 2. 딕셔너리에서 찾는다
        let meaning = wordDict[txt]
        
        // 3-1. 딕셔너리에 있으면, 화면에 뜻 출력
        if meaning != nil {
            meaningLabel.text = meaning
        }
        
        // 3-2. 딕셔너리에 없으면, alert 후 기본 이미지로 초기화
        else {
            let alert = UIAlertController(title: "없는 단어입니다", message: "다시 입력해주세요", preferredStyle: .alert)
            
            // 2. 취소 / 확인
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            let ok = UIAlertAction(title: "확인", style: .default)
            
            // 3. 연결
            alert.addAction(cancel)
            alert.addAction(ok)
            
            // 4. 띄우기
            present(alert, animated: true)
            
            // 기본 이미지로 변경
            backgroundImage.image = UIImage(named: "word_logo")
            meaningLabel.text = ""
        }
        
    }
    
    
    
    /*======= @IBAction =======*/
    // 키보드에서 return 키를 누른다
    @IBAction func keyboardReturnTapped(_ sender: UITextField) {
        showMeaning()
    }
    
    // search button 클릭
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        showMeaning()
    }
    
    // tap gesture - 키보드 내려가게
    @IBAction func tapgestrue(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // tag button 클릭
    @IBAction func wordButtonTapped(_ sender: UIButton) {
        
        // 1. textfield에 적히게
        searchTextField.text = sender.currentTitle
        
        // 2. 그대로 검색 (showMeaning)
        showMeaning()
        
    }
    
    
    
    
    /*
     궁금한 점
     textfield.text로 받는 값은 옵셔널
     근데 textfield에 아무것도 입력하지 않았을 때는 Optional("") 로
     빈 문자열이 나온다
     그럼 nil이 나오는 경우는 언제일까
     */
}
