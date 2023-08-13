//
//  SettingViewController.swift
//  0804practice
//
//  Created by 임승섭 on 2023/08/04.
//

import UIKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("setting", #function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("setting", #function)
    }
    override func viewDidAppear(_ animated: Bool) {
        print("setting", #function)
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("setting", #function)
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("setting", #function)
    }
    
    

    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        // 1. userdefault 수정
        UserDefaults.standard.set(false, forKey: "isLogin")
        print("UserDefault 변경. false")
        
        // 2. 루트 뷰까지 초기화
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let vc = storyboard?.instantiateViewController(identifier: "OnboardingViewController") as! OnboardingViewController
        sceneDelegate?.window?.rootViewController = vc
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}
