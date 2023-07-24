//
//  keyBoardViewController.swift
//  0719hw
//
//  Created by 임승섭 on 2023/07/20.
//

import UIKit

class keyBoardViewController: UIViewController {

    @IBOutlet var newButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // 이전에 배운 코드
        // newButton.backgroundColor = .blue
        
        // iOS 15 이상부터 들어가는 기능
        // configuration - filled, gray,...
        var config = UIButton.Configuration.filled() // apple system button
        config.title = "새싹 영등포캠퍼스"
        config.subtitle = "로그인 없이 둘러보기"
        config.image = UIImage(systemName: "pencil")
        config.baseForegroundColor = .blue      // system 이미지 색도 바뀐다
        config.baseBackgroundColor = .yellow
        
        config.imagePadding = 9     // (title, subtitle)과 image 간의 패딩
        config.titlePadding = 4     // title과 subtitle 간의 패딩
        config.imagePlacement = .bottom
        config.titleAlignment = .leading
        
        config.background.cornerRadius = 0
        config.cornerStyle = .capsule
        // .capsule, .large, .medium, .small : cornerRadius 무시하고 시스템에 저장된 값 사용
        // .fixed, .dynamic : cornerRadius 반영
        newButton.configuration = config

    }
    
    // 두 버튼을 눌렀을 때 동일하게 키보드가 내려가게 하기
    @IBAction func keyboardDismiss(_ sender: Any) {
        view.endEditing(true)
        
        // 타입이 UIButton일 때,
        // sender.titleLabel 등 확인 가능. Any에서는 불가능
    }
    // 두 버튼 뿐만 아니라, 화면을 터치했을 때도 키보드가 내려가게 하고 싶다.
    // 기존처럼 tapgesture에 위 함수를 그대로 연결하면 깔끔하다
    // 하지만 만약 매개변수 타입을 UIButton으로 했으면, 연결이 불가능하다
    // 따라서 tapgesture와 연결하기 위해서는 타입을 Any로 바꿔주어야 한다
    
    // 하지만 단점으로, Any 타입일 때는 UIButton의 속성 (sender.titleLabel, ...)에 접근할 수 없다
    
    // Any : 객체가 다르더라고 같은 기능을 넣고 싶을 때 사용한다
}
