//
//  TestViewController.swift
//  0727hw
//
//  Created by 임승섭 on 2023/07/27.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        let a = UIAction(title: "1") { _ in print("1")}
        let b = UIAction(title: "2") { _ in print("2")}
        let c = UIAction(title: "3") { _ in print("3")}
        
        let buttonMenu = UIMenu(title: "선택해라", children: [a, b, c])
        button1.menu = buttonMenu
        button2.menu = buttonMenu
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
