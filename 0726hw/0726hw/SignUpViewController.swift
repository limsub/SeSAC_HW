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
// -> 다음 화면으로 넘어가는 걸 코드로 배우지 않아서 이거 못한다. 따로 확인하는 버튼을 만들어보자
// 3. datepicker로 본인 생일 선택할 수 있도록 하기
// 4. 모든 값을 UserDefaults로 저장해서 다음 화면에서 확인할 수 있도록 하기

import UIKit

class SignUpViewController: UIViewController {
    
    let mine = UserDefaults.standard
    let format = DateFormatter()
    
    
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
    
    @IBOutlet var confirmButton: UIButton!
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
        
        // 확인 버튼 디자인
        confirmButton.setTitle("확인", for: .normal)
        confirmButton.backgroundColor = .systemPink
        confirmButton.tintColor = .white
        confirmButton.layer.cornerRadius = 10
        
        // 다음으로 버튼 디자인
        nextButton.setTitle("다음으로", for: .normal)
        nextButton.backgroundColor = .systemGray5
        nextButton.tintColor = .darkGray
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
        
        sender.tag = type.rawValue
        
        
        // switch -> placeholder
        switch type {
        case .id :
            sender.placeholder = "사용할 아이디를 입력하세요"
            sender.textContentType = .emailAddress
        case .password :
            sender.placeholder = "사용할 비밀번호를 입력하세요"
            sender.textContentType = .password
            sender.isSecureTextEntry = true
        case .confirmpassword :
            sender.placeholder = "비밀번호를 다시 한 번 입력하세요"
            sender.textContentType = .password
            sender.isSecureTextEntry = true
        case .nickname :
            sender.placeholder = "사용할 닉네임을 입력하세요"
            sender.textContentType = .nickname
        default :
            break;
        }
    }
    
    // 다음으로 넘어갈 수 있는 상태인지 확인
    func checkNextPage() -> Bool {
        if let t1 = idTextField.text, let t2 = passwordTextField.text,
           let t3 = passwordConfirmTextField.text, let t4 = nicknameTextField.text {
            if (!t1.isEmpty && !t2.isEmpty && !t3.isEmpty && !t4.isEmpty) &&
                (t2 == t3) {
                return true
            }
        }
        
        return false
    }
    
    
    // confirm button tapped
    @IBAction func confirmButtonTapped(_ sender: UIButton) {
        // 확인 조건
        // 1. textfield가 비어있으면 탈락
        // 2. 비밀번호랑 비밀번호 확인이 다르면 탈락
        // 3. 1, 2 아니면 통과
        
        var title: String = ""
        var message: String = ""
        
        if let t1 = idTextField.text, let t2 = passwordTextField.text,
           let t3 = passwordConfirmTextField.text, let t4 = nicknameTextField.text {
            
            if (t1.isEmpty) {
                title = "아이디를 입력하세요"
            }
            else if (t2.isEmpty) {
                title = "비밀번호를 입력하세요"
            }
            else if (t3.isEmpty) {
                title = "비밀번호 확인을 입력하세요"
            }
            else if (t4.isEmpty) {
                title = "닉네임을 입력하세요"
            }
            else if (t2 != t3) {
                title = "비밀번호가 일치하지 않습니다"
            }
            else {
                title = "모든 입력이 완료되었습니다"
                message = "다음으로 버튼을 눌러주세에요"
            }
        }

        // 1. 내용
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // 2. 확인
        let ok = UIAlertAction(title: "확인", style: .default)
        // 3. 연결
        alert.addAction(ok)
        // 4. 띄우기
        present(alert, animated: true)
    }
    
    // next button tapped
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
        format.dateFormat = "yyyy년 M월 dd일"
        
        mine.set(idTextField.text, forKey: "id")
        mine.set(passwordTextField.text, forKey: "pw")
        mine.set(nicknameTextField.text, forKey: "nickname")
        mine.set(format.string(from: birthdayPicker.date), forKey: "birthday")
    }
    
    
    @IBAction func datePickerTapped(_ sender: UIDatePicker) {
        
    }
    
    
    // tap gesture
    @IBAction func tapgestureTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    // 주의 : 여기서 땡겨서 스토리보드랑 연결할 때, Did End On Exit은 하나만 먹는다
    // Editing Changed로 입력하는 도중에 다음으로 버튼 색 바꿀 수도 있을 것 같은데
    // -> 찾아보자
    // 키보드의 return키를 누르면, 포커스가 다음 입력창으로 넘어가게 할 수 없을까
    @IBAction func returnKeyTapped(_ sender: UITextField) {
        switch sender.tag {
        case 0 :
            passwordTextField.becomeFirstResponder()
        case 1 :
            passwordConfirmTextField.becomeFirstResponder()
        case 2  :
            nicknameTextField.becomeFirstResponder()
        case 3 :
            view.endEditing(true)
        default :
            break;
        }
        
        
    }
    
    
    // 모든 입력이 완료되면 버튼 색이 변하게 설정
    // -> 이제 실제 버튼이 안눌리게도 하는 방법 찾아보자
    @IBAction func EditingIdTextfield(_ sender: UITextField) {
        if (checkNextPage()) {
            nextButton.tintColor = .white
            nextButton.backgroundColor = .systemPink
        }
        else {
            nextButton.tintColor = .darkGray
            nextButton.backgroundColor = .systemGray5
        }
    }
    
    
}
