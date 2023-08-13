//
//  LEDBoardViewController.swift
//  0724hw
//
//  Created by 임승섭 on 2023/07/24.
//

import UIKit

class LEDBoardViewController: UIViewController {

    // outlet
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var textColorButton: UIButton!
    @IBOutlet var mainTextField: UITextField!
    @IBOutlet var upperView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 디자인
        designMainLabel(mainLabel)
        designButton(sendButton, name: "보내기")
        designButton(textColorButton, name: "Aa")
        
        upperView.layer.cornerRadius = 10
        upperView.backgroundColor = .white
        
        // 텍스트필드의 테두리를 없애기 위한 작업 -> 오래걸림
        // borderStyle을 .none으로 해준다는 거 기억하기
        mainTextField.borderStyle = .none
        mainTextField.textColor = .red
    }
    
    
    /* 초기 디자인함수 */
    // 레이블
    func designMainLabel(_ sender: UILabel) {
        sender.text = "Hello Swift"
        sender.textColor = .red
        sender.textAlignment = .center
        sender.font = UIFont.boldSystemFont(ofSize: 40)
        sender.numberOfLines = 0
    }
    
    // 버튼
    func designButton(_ sender: UIButton, name: String) {
        
        sender.layer.cornerRadius = 10
        sender.layer.borderColor = UIColor.black.cgColor
        sender.layer.borderWidth = 1
        
        switch(name) {
        case "보내기":
            sender.tintColor = .black
        case "Aa":
            sender.tintColor = .red
        default:
            break;
        }
    }
    
    
    
    /* 기능 함수 */
    // 보내기 버튼 - 키보드 내려가기, 레이블 띄워주기
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        // 키보드 내려가기
        view.endEditing(true)
        
        // 레이블 띄워주기
        mainLabel.text = mainTextField.text
    }
    
    // 리턴키 - 키보드 내려가기, 레이블 띄워주기
    @IBAction func keyboardReturnTapped(_ sender: UITextField) {    // Did End On Exit
        // 키보드 내려가기 (자동 구현)
        // view.endEditing(true)
        
        // 레이블 띄워주기
        mainLabel.text = mainTextField.text
    }
    
    
    // 배경 선택 시 - 키보드 내려가기 or 상단 뷰 토글
    @IBAction func backgroundTapGesture(_ sender: UITapGestureRecognizer) {
        // 키보드 올라와 있는 상태 -> 키보드 내리기
        // 키보드 내려가 있는 상태 -> 상단 뷰 토글
        
        // 현재 키보드가 올라와있는지에 대한 변수가 필요하다 -> isEditing
        if (mainTextField.isEditing) {
            view.endEditing(true)
        }
        else {
            upperView.isHidden.toggle()
        }
        
    }
    
    
    // 텍스트 컬러 버튼 누르면 색깔 랜덤으로 변경 -> textfield, 버튼, 레이블
    @IBAction func colorButtonTapped(_ sender: UIButton) {
        
        // drand48() : [0.0, 1.0) 사이의 값을 반환
        let rRed = CGFloat(drand48())
        let rGreen = CGFloat(drand48())
        let rBlue = CGFloat(drand48())
        
        let setColor = UIColor(red: rRed, green: rGreen, blue: rBlue, alpha: 1.0)
        
        mainTextField.textColor = setColor
        textColorButton.tintColor = setColor
        mainLabel.textColor = setColor
    }
}
