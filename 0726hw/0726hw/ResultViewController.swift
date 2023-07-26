//
//  ResultViewController.swift
//  0726hw
//
//  Created by 임승섭 on 2023/07/26.
//

import UIKit

class ResultViewController: UIViewController {

    let mine = UserDefaults.standard
    
    
    
    @IBOutlet var mainLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        let id = mine.string(forKey: "id")
        let pw = mine.string(forKey: "pw")
        let nickname = mine.string(forKey: "nickname")
        let birthday = mine.string(forKey: "birthday")
        
        mainLabel.numberOfLines = 0
        
        if let id, let pw, let nickname, let birthday {
            mainLabel.text = "아이디 : \(id) \n비밀번호 : \(pw) \n닉네임 : \(nickname) \n생일 : \(birthday)"
        }
        else {
            mainLabel.text = "에러입니당"
        }
        
    }
    


}
