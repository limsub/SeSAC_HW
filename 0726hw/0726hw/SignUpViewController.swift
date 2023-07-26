//
//  SignUpViewController.swift
//  0726hw
//
//  Created by 임승섭 on 2023/07/26.
//

// 1. textfield들 열거형으로 구분하기
// 2. 모든 textfield들이 작성되어 있어야 다른 화면으로 넘어갈 수 있도록 하기.
//    다 채워져야 버튼 색이 변하게끔 -> 이건 못하겠다. 어디서 함수가 계속 실행되는지 모르겠음
//    만약 하나라도 없으면 alert -> alert title도 열거형으로 구분
// 3. datepicker로 본인 생일 선택할 수 있도록 하기
// 4. 모든 값을 UserDefaults로 저장해서 다음 화면에서 확인할 수 있도록 하기

import UIKit

class SignUpViewController: UIViewController {
    
    
    
    @IBOutlet var mainLabel: UILabel!
    
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var passwordLabel: UILabel!
    @IBOutlet var passwordConfirmLabel: UILabel!
    @IBOutlet var nicknameLabel: UILabel!
    @IBOutlet var birthdayLabel: UILabel!
    
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordConfirmTextField: UITextField!
    @IBOutlet var nicknameTextField: UITextField!
    
    @IBOutlet var birthdayPicker: UIDatePicker!
    
    @IBOutlet var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // 메인 레이블 디자인
        mainLabel.text = "회원가입"
        mainLabel.textColor = .black
        mainLabel.font = UIFont.boldSystemFont(ofSize: 30)
        
        // 서브 레이블 디자인
        designSubLabel(idLabel, .id)
        designSubLabel(passwordLabel, .password)
        designSubLabel(passwordConfirmLabel, .confirmpassword)
        designSubLabel(nicknameLabel, .nickname)
        designSubLabel(birthdayLabel, .birthday)
        
        // 텍스트필드 디자인
        designTextField(idTextField, .id)
        designTextField(passwordTextField, .password)
        designTextField(passwordConfirmTextField, .confirmpassword)
        designTextField(nicknameTextField, .nickname)
        
        // 데이트피커 디자인
        birthdayPicker.preferredDatePickerStyle = .compact
        birthdayPicker.datePickerMode = .date
        
        // 다음으로 버튼 디자인
        nextButton.setTitle("다음으로", for: .normal)
        nextButton.backgroundColor = .systemPink
        nextButton.tintColor = .white
        nextButton.layer.cornerRadius = 10
        
    }
    
    // 서브 레이블 디자인 함수
    func designSubLabel(_ sender: UILabel, _ type: Sign) {
        // 공통
        sender.textColor = .gray
        sender.font = UIFont.systemFont(ofSize: 12)
        
        // switch
        switch type {
        case .id :
            sender.text = "아이디"
        case .password :
            sender.text = "비밀번호"
        case .confirmpassword :
            sender.text = "비밀번호 확인"
        case .nickname :
            sender.text = "닉네임"
        case .birthday :
            sender.text = "생년월일"
        }
    }
    
    // 텍스트필드 디자인 함수
    func designTextField(_ sender: UITextField, _ type: Sign) {
        
        // 공통
        sender.backgroundColor = .systemGray6
        sender.layer.cornerRadius = 10
        sender.borderStyle = .none
        // textfield padding 넣어주기?
        sender.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        sender.leftViewMode = .always
        
        
        // switch -> placeholder
        switch type {
        case .id :
            sender.placeholder = "사용할 아이디를 입력하세요"
        case .password :
            sender.placeholder = "사용할 비밀번호를 입력하세요"
        case .confirmpassword :
            sender.placeholder = "비밀번호를 다시 한 번 입력하세요"
        case .nickname :
            sender.placeholder = "사용할 닉네임을 입력하세요"
        default :
            break;
        }
    }

}
