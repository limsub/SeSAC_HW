//
//  EmotionResultViewController.swift
//  0725hw
//
//  Created by 임승섭 on 2023/07/25.
//

import UIKit

class EmotionResultViewController: UIViewController {

    // view와 감정 이름 레이블은 굳이 enum을 쓸 필요가 없고, 디자인만 할 거라서 outlet collection으로 저장한다
    
    @IBOutlet var resultViews: [UIView]!
    @IBOutlet var nameLabels: [UILabel]!
    
    

    @IBOutlet var emojiPoints: [UILabel]!
    
    
    
    @IBOutlet var ss: UIButton!
    let names = ["완전행복지수", "적당미소지수", "그냥그냥지수", "좀속상한지수", "많이슬픈지수"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 0...resultViews.count-1 {
            designView(resultViews[i], i)
            nameLabels[i].text = names[i]
            nameLabels[i].textColor = .white
            
            emojiPoints[i].text = "\(UserDefaults.standard.integer(forKey: "\(names[i])")) 점"
            emojiPoints[i].textColor = .white
            emojiPoints[i].font = UIFont.systemFont(ofSize: 30)
        }
        
        
        
        // pull down button 연습
        let ok = UIAction(title: "확인", handler: { _ in print("확인") })
        let cancel = UIAction(title: "취소", attributes: .destructive, handler: { _ in print("취소") })
        let buttonMenu = UIMenu(title: "메뉴 타이틀", children: [ok, cancel])
        ss.menu = buttonMenu
    }
    
    
    // 탭을 왔다갔다 할 때 viewDidLoad가 계속 실행되는 건 아니기 때문에
    // viewWillAppear가 실행될 때 점수 업데이트를 해준다
    override func viewWillAppear(_ animated: Bool) {
        
        for i in 0...resultViews.count-1 {
            emojiPoints[i].text = "\(UserDefaults.standard.integer(forKey: "\(names[i])")) 점"
        }
    }
    
    func designView(_ sender: UIView, _ index: Int) {
        sender.layer.cornerRadius = 10
        switch index {
        case 0:
            sender.backgroundColor = .systemPink
        case 1:
            sender.backgroundColor = .systemOrange
        case 2:
            sender.backgroundColor = .systemYellow
        case 3:
            sender.backgroundColor = .systemCyan
        case 4:
            sender.backgroundColor = .systemBlue
        default:
            break
        }
    }
    
    
}
