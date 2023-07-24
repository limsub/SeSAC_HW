//
//  AnniversaryViewController.swift
//  0720hw
//
//  Created by 임승섭 on 2023/07/20.
//

import UIKit

class AnniversaryViewController: UIViewController {

    // 4개의 이미지 뷰를 배열로 저장
    @IBOutlet var backgroundImageViews: [UIImageView]!
    
    // 그림자를 위한 4개의 뷰를 배열로 저장
    @IBOutlet var forShadowViews: [UIView]!
    
    // 4개의 이미지 asset 이름
    let assetNames = ["churros", "cake", "icecream", "doughnut"]
    
    // 4개의 디데이 배열 (
    let dDay = [100, 200, 300, 400]
    // 디데이 레이블
    @IBOutlet var dDayLabels: [UILabel]!
    // 4개의 디데이 날짜 레이블
    @IBOutlet var dDayDateLabels: [UILabel]!
    
    // datepicker
    @IBOutlet var goodDatePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // DateFormatter 만들기 0000년 0월 00일
        let format = DateFormatter()
        format.dateFormat = "yyyy년 M월 dd일"
        
        // 4개의 칸 디자인
        for i in 0...3 {
            // 이미지 뷰와 그림자 뷰
            designImageView(backgroundImageViews[i], assetName: assetNames[i])
            designShadowView(forShadowViews[i])
            
            // 디데이 레이블
            dDayLabels[i].text = "D + \(dDay[i])"
            dDayLabels[i].textColor = .white
            dDayLabels[i].font = .boldSystemFont(ofSize: 25)
            
            // 디데이 날짜 레이블
            // 화면이 켜지자마자 출력해야 한다
            // 1. 내 생각 : 오늘 날짜 기준으로 계산해서 출력한다
            // 2. 과제설명 : datePicker에 선택된 날짜 기준으로 계산해서 출력한다
            
            /* 1
            let result = Calendar.current.date(byAdding: .day, value: dDay[i], to: Date())
            
            dDayDateLabels[i].text = format.string(from: result!)
            dDayDateLabels[i].textColor = .white
            dDayDateLabels[i].textAlignment = .center
             */
            
        }
        // 2
        datePickerValueChanged(goodDatePicker)
        
    }
    
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        
        // DateFormatter 만들기 0000년 0월 00일
        let format = DateFormatter()
        format.dateFormat = "yyyy년 M월 dd일"
        
        // 각 칸의 디데이에 맞춰서 날짜 출력
        for i in 0...3 {
            let result = Calendar.current.date(byAdding: .day, value: dDay[i], to: sender.date)
            
            dDayDateLabels[i].text = format.string(from: result!)
            dDayDateLabels[i].textColor = .white
            dDayDateLabels[i].textAlignment = .center
        }
    }
    
    
    // 이미지 뷰 디자인 함수
    func designImageView(_ name: UIImageView, assetName: String) {
        name.image = UIImage(named: assetName)
        
        name.contentMode = .scaleAspectFill
        name.layer.cornerRadius = 20
//        name.layer.shadowColor = UIColor.black.cgColor
//        name.layer.shadowOffset = CGSize(width: 10, height: 10)
//        name.layer.shadowRadius = 10
//        name.layer.shadowOpacity = 0.5
        name.clipsToBounds = true
        
        // cornerRadius와 shadow를 동시에 줄 수 없다 <- clipsToBound에서 걸린다
        // 방법 1.
        // 다른 뷰를 겹쳐서 해당 뷰에 그림자를 준다
        // 이미지가 보여야 하기 때문에 새로운 뷰를 이미지 뷰보다 아래에 위치시킨다
        // 근데, 뷰를 같은 사이즈로 하니까 테두리 곡선에 삐져나와서, 이미지 뷰보다 사이즈를 줄여서 넣어주었다
    }
    
    // 그림자 뷰 디자인 함수
    func designShadowView(_ name: UIView) {
        
        name.clipsToBounds = false
        name.layer.shadowColor = UIColor.black.cgColor
        name.layer.shadowOffset = CGSize(width: 15, height: 15)
        name.layer.shadowRadius = 20
        name.layer.shadowOpacity = 0.8
        name.layer.shadowPath = UIBezierPath(roundedRect: name.bounds, cornerRadius: 20).cgPath
    }
    
}
