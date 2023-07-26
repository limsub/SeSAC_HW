//
//  JackFlixViewController.swift
//  0719hw
//
//  Created by 임승섭 on 2023/07/19.
//

import UIKit

// 7/26
enum TextFieldType: Int {
    case id = 100
    case pw = 200
    case nickName = 300
}

class JackFlixViewController: UIViewController {
    
    
    @IBOutlet var totalView: UIView!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var nickNameTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var recommendCodeTextField: UITextField!
    
    @IBOutlet var signUpButton: UIButton!
    
    @IBOutlet var additionalInfoLabel: UILabel!
    @IBOutlet var additionalInfoSwitch: UISwitch!
    
    var cnt = 0
    @IBOutlet var buttonCountLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 배경 디자인
        totalView.backgroundColor = .black
        
        // 제목(JackFlix) 디자인
        titleLabel.text = "JACKFLIX"
        titleLabel.textColor = .red
        titleLabel.font = .boldSystemFont(ofSize: 30)
        titleLabel.textAlignment = .center
        
        // textfield 초기 디자인
        designTextField(emailTextField, message: "이메일 주소 또는 전화번호")
        designTextField(passwordTextField, message: "비밀번호")
        designTextField(nickNameTextField, message: "닉네임")
        designTextField(locationTextField, message: "위치")
        designTextField(recommendCodeTextField, message: "추천 코드 입력")
        
        // 회원가입 버튼 디자인
        signUpButton.layer.cornerRadius = 10
        signUpButton.setTitle("회원가입", for: .normal)
        signUpButton.setTitleColor(.black, for: .normal)
        signUpButton.setTitleColor(.black, for: .highlighted)
        signUpButton.backgroundColor = .white
        //signUpButton.titleLabel?.font = .boldSystemFont(ofSize: 50)
        
        // 추가 정보 입력
        additionalInfoLabel.text = "추가 정보 입력"
        additionalInfoLabel.textColor = .white
        
        // 스위치
        additionalInfoSwitch.onTintColor = .red
        additionalInfoSwitch.tintColor = .white
        additionalInfoSwitch.backgroundColor = .white
        additionalInfoSwitch.layer.cornerRadius = 16
        additionalInfoSwitch.isOn = false
        
        
        // 7/26
        // 코드로 tag 지정하기
        // enum의 rawValue를 준다
        emailTextField.tag = TextFieldType.id.rawValue
        passwordTextField.tag = TextFieldType.pw.rawValue
        nickNameTextField.tag = TextFieldType.nickName.rawValue
        
        // UserDefaults
        let e = UserDefaults.standard.string(forKey: "id")
        let p = UserDefaults.standard.string(forKey: "pw")
        let n = UserDefaults.standard.string(forKey: "nickName")
        
        if let e, let p, let n {
            emailTextField.text = e
            passwordTextField.text = p
            nickNameTextField.text = n
        }
        
        // 만약 이상한 값을 Key로 준다면?
        let testString = UserDefaults.standard.string(forKey: "testS")
        let testInt = UserDefaults.standard.integer(forKey: "testI")
        let testBool = UserDefaults.standard.bool(forKey: "testB")
        
        print(testString, testInt, testBool)    // nil, 0, false
        // String만 옵셔널이고, Int랑 Bool은 타입 그대로 가는구나
        
        // 버튼 누른 횟수
        // Jack 방법 - 전역변수를 따로 선언하지 않고, 그때그때 값을 받아와서 처리하는 느낌
        let value = UserDefaults.standard.integer(forKey: "count2")
        buttonCountLabel.text = "버튼 클릭 횟수 : \(value)"
    }
    
    
    // textfield 디자인하는 함수
    func designTextField(_ name: UITextField, message: String) {
        name.placeholder = message
        //name.attributedPlaceholder
        name.backgroundColor = .gray
        name.textColor = .white
        
        // 만약 비밀번호 입력 창이면 secure
        if (message == "비밀번호") {
            name.isSecureTextEntry = true
        }
    }
    
    // 회원가입 버튼 누르면 alert 창
    @IBAction func signUpButtonClicked(_ sender: UIButton) {
        // 1. 내용
        let content = "닉네임 : \(nickNameTextField.text!)"
        let alert = UIAlertController(title: "회원가입 완료", message: content, preferredStyle: .alert)
        
        // 2. 취소 / 확인
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default)
        
        // 3. 연결
        alert.addAction(cancel)
        alert.addAction(ok)
        
        // 4. 띄우기
        present(alert, animated: true)
        
        
        
    }
    
    // tab gesture
    @IBAction func tapGesturedTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    
    
    // 7/26
    // 맨 위 이메일 textfield는 return 누르면 키보드 내려가는데,
    // 그 밑에 애들은 내려가지 않음;;
    // 맨 위 이메일 : return키 누르면 내려가고 출력. 배경 선택하면 내려가고 출력x
    // 그 밑에 애들 : return키 누르면 안내려가고 안출력. 배경 선택하면 내려가고 출력
    // -> 인스펙터 영역에서 셋 다 Did End on Exit으로 바꿔주기
    @IBAction func keyboardTapped(_ sender: UITextField) {
        print("키보드 리턴키 클릭 : \(sender.tag)")
        
        
        // else에 반드시 return이 있어야 하는 이유
        // 만약 nil이 발생했다면, else문이 실행되지만,
        // 아래에도 계속 코드가 있기 때문에 아래 코드도 실행된다
        // 이를 방지하고자 미리 함수를 종료시키기 위해 else 안에 return을 써준다
        guard let text = sender.text, let value = TextFieldType(rawValue: sender.tag) else {
            print("오류가 발생했습니다")
            return
        }
        
        // 1. 단순 if문
//        if sender.tag == TextFieldType.id.rawValue {
//            print("아이디는 \(text)입니다")
//        }
//        else if (sender.tag == TextFieldType.pw.rawValue) {
//            print("비밀번호는 \(text)입니다")
//        }
//        else if (sender.tag == TextFieldType.nickName.rawValue) {
//            print("닉네임은 \(text)입니다")
//        }
        
        // 2. 단순 switch문
//        switch (sender.tag) {
//        case TextFieldType.id.rawValue : print("아이디는 \(text)입니다")
//        case TextFieldType.pw.rawValue : print("비밀번호는 \(text)입니다")
//        case TextFieldType.nickName.rawValue : print("닉네임은 \(text)입니다")
//        default: break;
//        }
        
        // 3. 역으로 enum case를 가져옴
        //let value = TextFieldType(rawValue: sender.tag) // 얘도 옵셔널인거 주의 -> guard let
        //guard let value = TextFieldType(rawValue: sender.tag) else { return }
        switch value {
        case .id : print("아이디는 \(text)입니다")
        case .pw : print("비밀번호는 \(text)입니다")
        case .nickName : print("닉네임은 \(text)입니다")
            
        }
    }
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        UserDefaults.standard.set(emailTextField.text!, forKey: "id")
        UserDefaults.standard.set(passwordTextField.text!, forKey: "pw")
        UserDefaults.standard.set(nickNameTextField.text!, forKey: "nickName")
        
        print("저장하였습니다")
        
        
        // 저장 버든 클릭 횟수를 저장한다
        
        // 내 방법
        cnt += 1
        UserDefaults.standard.set(cnt, forKey: "count")
        //buttonCountLabel.text = "버튼 클릭 횟수 : \(cnt)"
        
        // Jack 설명
        // 1. 저장된 횟수 가지고 오기
        let value = UserDefaults.standard.integer(forKey: "count2")
        // 2. 저장된 횟수에 1 더해주기
        let result = value + 1
        // 3. 더한 값을 다시 저장해주기
        UserDefaults.standard.set(result, forKey: "count2")
        
        buttonCountLabel.text = "버튼 클릭 횟수 : \(result)"
    }
    
    
    
    

}
