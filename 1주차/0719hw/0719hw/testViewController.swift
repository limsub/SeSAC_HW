//
//  testViewController.swift
//  0719hw
//
//  Created by 임승섭 on 2023/07/20.
//

import UIKit

class testViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func alert(_ sender: UIButton) {
        
        // UIAlertController를 만들고, preferredStyle에
        // alert 또는 actionSheet을 적어서 구분한다
        
        // 보통 action sheet은 타이틀과 메세지를 넣지 않는다.
        // 1. 빈 문자열 -> 공간은 차지하고 있는다
        // 2. nil -> 공간조차 쓰지 않게 된다
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let button1 = UIAlertAction(title: "11", style: .destructive)   // .destructive : 빨간색
        let button2 = UIAlertAction(title: "22", style: .cancel)    // .cancel : 취소
        // cancel이 두개면 어떻게 될까? -> 에러 발생
        
        let button3 = UIAlertAction(title: "333", style: .default)  //  .default : 파란색
        let button4 = UIAlertAction(title: "444", style: .default)
        
        
        // (순서 중요) 붙여주는 순서대로 버튼이 붙는다
        alert.addAction(button4)    // 맨 위에
        alert.addAction(button3)    // 그 밑에
        alert.addAction(button2)    // 얘는 cancel style이라 알아서 자기 자리 찾아간다
        alert.addAction(button1)    // 그 밑에
        
        
        // 원래 매개변수의 타입은 UIViewController이다.
        // UIAlertController가 걔를 상속받고 있기 때문에 매개변수로 사용 가능하다
        //present(<#T##viewControllerToPresent: UIViewController##UIViewController#>, animated: <#T##Bool#>)
        present(alert, animated: true)
        
        
        // action sheet는 뒷 배경 터치하면 팝업창이 내려가지만,
        // alert는 내려가지 않는다.
    }
}
