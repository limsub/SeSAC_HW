//
//  NewPageViewController.swift
//  0726hw
//
//  Created by 임승섭 on 2023/07/27.
//

import UIKit

class NewPageViewController: UIViewController {

    
    @IBOutlet var resultLabel: UILabel!
    
    
    // 탭바 컨트롤러 : 탭 클릭 전까지 ViewDidLoad는 호출되지 않음
    // + 또한, root view이기 때문에 다른 탭 갔다와도 ViewDidLoad가 재실행되지 않음
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    // 그래서 viewWillAppear에 업데이트되는 내용을 적어준다
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let count = UserDefaults.standard.integer(forKey: "count")
        resultLabel.text = "\(count)"
    }
    
}
