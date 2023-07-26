//
//  TestViewController.swift
//  0725hw
//
//  Created by 임승섭 on 2023/07/25.
//

import UIKit

class TestViewController: UIViewController {

    
    @IBOutlet var buttons: [UIButton]!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...buttons.count-1 {
            
            buttons[i].setTitle("\(i)", for: .normal)
        }

        // Do any additional setup after loading the view.
    }
    

    
    
    

}
