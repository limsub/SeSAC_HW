//
//  EmotionCountViewController.swift
//  0725hw
//
//  Created by 임승섭 on 2023/07/25.
//


// 7/26 update
// 1. enum 좀 더 다양하게 써보기
// 2. tag 코드로 구현
// 3. UserDefaults 손보기
// 4. reset 버튼 -> alert 띄워주기 (확인 / 취소)


import UIKit

class EmotionCountViewController: UIViewController {
    
    /* 원래 생각
     버튼들을 하나의 배열에 저장해서
     각 버튼에 접근하는 방식을 index 번호로 처리함
     index번호와 tag가 동일하기 때문에 접근이 용이함
     */
    
    
    /* 열거형 이용해보기
     버튼들을 따로 outlet으로 저장해서, 각 버튼별로
     디자인할 때 열거형에 따라 디자인되도록 함
     */
    
    // 버튼 개수를 특정지어서 5라고 안하고, 배열의 count를 계산하였다
    
    // Outlet collection으로 버튼들 가졍
    // Q. 배열에 저장되는 순서는, 스토리보드에 연결한 순서일까?
    //@IBOutlet var emotionButton: [UIButton]!
    
    
    
    // 버튼 outlet
    @IBOutlet var veryGoodButton: UIButton!
    @IBOutlet var goodButton: UIButton!
    @IBOutlet var sosoButton: UIButton!
    @IBOutlet var badButton: UIButton!
    @IBOutlet var veryBadButton: UIButton!
    

    @IBOutlet var pullDownButton3: UIBarButtonItem!
    
    // 몇 점씩 올릴지 변수
    var m = 1;
    
    
    // 각 버튼의 터치 횟수 (카운트 수)
    var countNum = [0, 0, 0, 0, 0]
    let names = ["완전행복지수", "적당미소지수", "그냥그냥지수", "좀속상한지수", "많이슬픈지수"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // countNum 초기화
        for i in 0...4 {
            countNum[i] = 0
            UserDefaults.standard.set(countNum[i], forKey: names[i])
        }

        designButton(veryGoodButton, Emotion(rawValue: 0)!)
        designButton(goodButton, Emotion(rawValue: 1)!)
        designButton(sosoButton, Emotion(rawValue: 2)!)
        designButton(badButton, Emotion(rawValue: 3)!)
        designButton(veryBadButton, Emotion(rawValue: 4)!)
        
        designPullDownButton(pullDownButton3)
    }
    
    // 버튼 디자인
    func designButton(_ sender: UIButton, _ emoji: Emotion) {
        
        // (0726) tag 지정
        sender.tag = emoji.rawValue
        
        switch emoji {
        case .veryGood:
            sender.setImage(UIImage(named: "emoji1"), for: .normal)
            sender.backgroundColor = .systemPink
        case .good:
            sender.setImage(UIImage(named: "emoji2"), for: .normal)
            sender.backgroundColor = .systemOrange
        case .soso:
            sender.setImage(UIImage(named: "emoji3"), for: .normal)
            sender.backgroundColor = .systemYellow
        case .bad:
            sender.setImage(UIImage(named: "emoji4"), for: .normal)
            sender.backgroundColor = .systemCyan
        case .veryBad:
            sender.setImage(UIImage(named: "emoji5"), for: .normal)
            sender.backgroundColor = .systemBlue
        // default 구문 필요 없다
        }
    }
    
    // pull down button 디자인
    func designPullDownButton(_ sender: UIBarButtonItem) {
        sender.image  = UIImage(systemName: "pencil.circle")
        
        let mul1 = UIAction(title: "x 1", handler: {_ in self.m = 1})
        let mul5 = UIAction(title: "x 5", handler: {_ in self.m = 5})
        let mul10 = UIAction(title: "x 10", handler: {_ in self.m = 10})
        
        
        let buttonMenu = UIMenu(title: "점수를 선택하세요", children: [mul1, mul5, mul10])
        
        sender.menu = buttonMenu
    }
    
    
    
    
    @IBAction func emotionButtonTapped(_ sender: UIButton) {
        countNum[sender.tag] += m
        
        UserDefaults.standard.set(countNum[sender.tag], forKey: names[sender.tag])
        
        
        print("현재 감정(\(sender.tag)) 터치 횟수 : \(countNum[sender.tag])")
    }
    
    

    // 시간 걸리는 중
    // pull down button 구현중인데, 그냥 바깥에다가 둘 때는 정상적으로 작동
    // navigation bar 안에 넣어서 UIBarButtonItem이 되면 작동하지가 않는다
    
    // UIButton을 Navigation bar 안에 넣으면 UIBarButtonItem이 되는데
    // 그냥 UIButton으로 했을 때와 어떤 차이가 있는지
    
    // Navigation bar 안에 버튼을 넣을 땐 반드시 UIBarButton으로 넣어줘야 한다!!!
    
    
    // (0726) reset Button alert
    @IBAction func resetButtonTapped(_ sender: UIBarButtonItem) {
        
        // 1. 내용

        let alert = UIAlertController(title: "버튼 횟수를 모두 초기화하시겠습니까?", message: "count는 (x 1)로 초기화됩니다", preferredStyle: .alert)
        
        // 2. 취소 / 확인
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            self.m = 1
            for i in 0...4 {
                self.countNum[i] = 0
                UserDefaults.standard.set(self.countNum[i], forKey: self.names[i])
            }
        }
        
        // 3. 연결
        alert.addAction(cancel)
        alert.addAction(ok)
        
        // 4. 띄우기
        present(alert, animated: true)
    }
}
