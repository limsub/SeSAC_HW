//
//  MainViewController.swift
//  0804practice
//
//  Created by 임승섭 on 2023/08/04.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("main", #function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("main", #function)
    }
    override func viewDidAppear(_ animated: Bool) {
        print("main", #function)
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("main", #function)
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("main", #function)
    }
    
    @IBAction func settingButtonTapped(_ sender: UIButton) {
        // 화면 이동
        // 1 + 2. 같은 스토리보드
        let vc = storyboard?.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
        
        // 3. 화면 전환 방식
        vc.modalPresentationStyle = .fullScreen
        
        // 4. 화면 띄우기
        present(vc, animated: true)
    }
    
}
