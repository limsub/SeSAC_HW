//
//  JackFlixViewController.swift
//  0719hw
//
//  Created by 임승섭 on 2023/07/19.
//

import UIKit

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
    
    

}
