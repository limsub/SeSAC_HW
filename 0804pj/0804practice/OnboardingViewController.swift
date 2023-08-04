//
//  OnboardingViewController.swift
//  0804practice
//
//  Created by 임승섭 on 2023/08/04.
//

import UIKit

class OnboardingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("onboarding", #function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("onboarding", #function)
    }
    override func viewDidAppear(_ animated: Bool) {
        print("onboarding", #function)
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("onboarding", #function)
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("onboarding", #function)
    }


    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        // login되었다고 상태 저장
        UserDefaults.standard.set(true, forKey: "isLogin")
        print("UserDefault 변경. true")
        
        // 다음 화면 넘어감
        // 1 + 2. 같은 스토리보드
        let vc = storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        
        // 3. 화면 전환 방식
        vc.modalPresentationStyle = .fullScreen
        
        // 4. 화면 띄우기
        present(vc, animated: true)
        
    }
    
}
