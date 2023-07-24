//
//  mainScreenViewController.swift
//  0719hw
//
//  Created by 임승섭 on 2023/07/19.
//

import UIKit


class mainScreenViewController: UIViewController {
    
    // 미리보기 포스터
    @IBOutlet var previewFirstImageView: UIImageView!
    @IBOutlet var previewSecondImageView: UIImageView!
    @IBOutlet var previewThirdImageView: UIImageView!
    @IBOutlet var posterImageView: UIImageView!
    
    
    
    @IBOutlet var randomPlayButton: UIButton!
    @IBOutlet var informationLabel: UILabel!
    
    // 이미지에 보여줄 그림 이름
    let random = [1, 2, 3, 4, 5]
    let random2 = ["극한직업", "도둑들", "명량", "부산행", "신과함께인과연", "베테랑"]
    let random3 = ["신과함께죄와벌", "아바타", "알라딘", "암살", "어벤져스엔드게임"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        showRandomMovie()
        designPreviewImageView(previewFirstImageView, borderColor: UIColor.red.cgColor)
        designPreviewImageView(previewSecondImageView, borderColor: UIColor.red.cgColor)
        designPreviewImageView(previewThirdImageView, borderColor: UIColor.red.cgColor)
        
        
        
        designRandomPlayButtonAction()
        
        let randomResult2 = random2.randomElement()!
        previewSecondImageView.image = UIImage(named: randomResult2)
        
    }
    
    
    
    @IBAction func likeButtonClicked(_ sender: UIButton) {
        // (1)
        let alert = UIAlertController(title: "이곳이 타이틀입니다", message: "이러쿵 저러쿵 내용을 작성하세요", preferredStyle: .alert)
        
        // (2)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default)
        
        // (3)
        alert.addAction(cancel)
        alert.addAction(ok)
        
        // (4)
        present(alert, animated: true)
    }
    
    
    @IBAction func playButtonClicked(_ sender: UIButton) {
        showRandomMovie()
    }
    
    
    // 함수로 정리
    func showRandomMovie() {
        
        let randomResult = random.randomElement()!
        let randomResult2 = random2.randomElement()!
        let randomResult3 = random3.randomElement()!
        
        previewFirstImageView.image = UIImage(named: "\(randomResult)")
        previewSecondImageView.image = UIImage(named: "\(randomResult2)")
        previewThirdImageView.image = UIImage(named: "\(randomResult3)")
    }

    
    func designPreviewImageView(_ name: UIImageView, borderColor: CGColor) {
        name.layer.cornerRadius = 50
        name.layer.borderColor = borderColor
        name.layer.borderWidth = 5
        name.backgroundColor = .blue
        name.contentMode = .scaleAspectFill
        
        
    }
    
    
    
    
    func designRandomPlayButtonAction() {
        //        randomPlayButton.setTitle("재생", for: .normal)   // 보통의 상태 (일반적인 상황에서 버튼을 어떻게 설정할지)
        //        randomPlayButton.setTitle("눌러주세요", for: .highlighted)   // 버튼을 꾹 누르고 손가락 떼지 않은 상태
        //        randomPlayButton.setTitleColor(.white, for: .normal)
        //        randomPlayButton.setTitleColor(.red, for: .highlighted)
                
        randomPlayButton.setImage(UIImage(named:"play_normal"), for: .normal)
        randomPlayButton.setImage(UIImage(named:"play_highlighted"), for: .highlighted)
        
        // 코드 길어지는게 보기 싫어서 따로 상수로 저장
        let normal = UIImage(named: "play_normal")
        randomPlayButton.setImage(normal, for: .normal)
        
        randomPlayButton.layer.cornerRadius = 10
        //randomPlayButton.layer.borderColor = UIColor.red.cgColor
        //randomPlayButton.layer.borderWidth = 4
    }
}
