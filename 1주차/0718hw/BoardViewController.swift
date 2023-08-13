//
//  BoardViewController.swift
//  0718hw
//
//  Created by 임승섭 on 2023/07/19.
//

import UIKit

// 소문자로 바꿈 -> 파일명이랑 달라도 된다
// 실질적으로 중요한건 class명 (인스펙터에서 확인 가능)
class BoardViewController: UIViewController {    // 기능을 상속
    
    
    @IBOutlet var boardTextField: UITextField!
    @IBOutlet var boardLabel: UILabel!
    
    
    // 레이블 여러 개를 한번에 관리
    // Outlet Collection
    @IBOutlet var testLabel: [UILabel]!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for item in testLabel {
            item.textColor = .red
            item.font = .boldSystemFont(ofSize: 15)
            
        }
        
        designLabel()
        designTextField()
    }
    

    @IBAction func checkButtonClicked(_ sender: UIButton) {
        boardLabel.text = boardTextField.text
        boardTextField.text = ""
    }
    
    @IBAction func tapGestureTapped(_ sender: UITapGestureRecognizer) {
        // view는 디폴트 이름. 인스펙터 맨 끝에 지울 수 없는 거 하나 확인 가능
        view.endEditing(true)
    }
    
    func designLabel() {
        
        boardLabel.textAlignment = .center
        boardLabel.text = "안녕하세요"
        boardLabel.font = .boldSystemFont(ofSize: 20)
        boardLabel.textColor = .systemPurple
        boardLabel.numberOfLines = 3    // 기본적으로 디폴트는 1줄 -> 길면 ...으로 뜬다
        // 몇 줄 쓸지 모르는 건 어떻게 할까 -> 0 준다
    }
    
    func designTextField() {
        boardTextField.placeholder = "내용을 입력하세요"
        boardTextField.textColor = .black
        boardTextField.keyboardType = .emailAddress
        boardTextField.borderStyle = .line
        
    }
    
}
