//
//  MovieViewController.swift
//  0718hw
//
//  Created by 임승섭 on 2023/07/19.
//

import UIKit

class MovieViewController: UIViewController {

    // IB : Interface Builder의 약자 - 단순히 변수가 아니라 스토리보드의 요소를 가져와서 만든거구나 하는 인식표
    
    @IBOutlet var previewFirstImageView: UIImageView!
    @IBOutlet var previewSecondImageView: UIImageView!
    @IBOutlet var previewThirdImageView: UIImageView!
    
    @IBOutlet var posterImageView: UIImageView!
    
    
    // 옆에 동그라미가 비어있으면 연결이 안된거다 (95% 확률?..)
    @IBOutlet var randomPlayButton: UIButton!
    // 나머지 5% -> 인스펙터 부분에서 땡겨오는 것도 가능
    @IBOutlet var informationLabel: UILabel!
    
    // 이름 수정 infoLabel -> informationLabel
    // firstImageView -> previewFirstImageView
    // 이름을 수정하고 나면 오류가 난다 - 아래 코드에서도 다 바꿔준다
    // 아래 변수도 다 바꿔주면 xCode 상에서는 문제 x
    // 하지만 실행하자마자 오류 발생 -> 인스펙터 상에서도 기존꺼 삭제하고 새로운거 연결해주자
    
    let random = [1, 2, 3, 4, 5]
    let random2 = ["극한직업", "도둑들", "명량", "부산행", "신과함께인과연", "베테랑"]
    
    
    
    // 사요앚에게 화면이 보이기 직전에 실행되는 부분
    // 모서리 둥글기, 그림자 등 스토리보드에서 설정할 수 없는 UI를 설정할 때 주로 사용
    // 뷰컨트롤러 생명 주기
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 내가 짠거
        //previewFirstImageView.image = UIImage(named: String(Int.random(in: 1...5)))
        
        // Jack이 짠거 - 1
//        let random = Int.random(in: 1...5)  // viewDidLoad 내에서만 실행되고 그동안 바뀌지는 않기 때문에 let으로 선언 가능
//        previewFirstImageView.image = UIImage(named: "\(random)")
        
        // Jack이 짠거 - 2
        //let random = [1, 2, 3, 4, 5]
//        let randomResult = random.randomElement()!  // 만약 random 배열이 var라면, 빈 배열이 될 수도 있다. -> 옵셔널
//        previewFirstImageView.image = UIImage(named: "\(randomResult)")
        
        // 결국 - 함수 호출
        
        
        // 함수로 만들어서 호출해주기
        showRandomMovie()
        
        // Argument(전달인자) : 함수 호출 시 전달하는 값 (실질적인 값) (시시각각 변화)
        designPreviewImageView(previewFirstImageView, borderColor: UIColor.red.cgColor)
        designPreviewImageView(previewSecondImageView, borderColor: UIColor.blue.cgColor)
        designPreviewImageView(previewThirdImageView, borderColor: UIColor.green.cgColor)
        
        
        
        designRandomPlayButtonAction()
        
        
        // let random2 = ["극한직업", "도둑들", "명량", "부산행", "신과함께인과연", "베테랑"]
        let randomResult2 = random2.randomElement()!
        previewSecondImageView.image = UIImage(named: randomResult2)
        
    }
    
    
    
    // alert 구현
    // (1) 내용, (2) 확인 취소, (3) 1,2 붙여주기, (4) 띄워주기
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
    
    
    
    
    // 함수 이름 변경 randomPlayButto -> playButton
    // 클릭하기 전까지는 오류x -> 클릭하면 에러 남
    // 똑같이 커넥션 인스펙터 열어서 지우고 다시 연결
    @IBAction func playButtonClicked(_ sender: UIButton) {
        showRandomMovie()
    }
    
    
    // 함수로 정리
    func showRandomMovie() {
        //let random = [1, 2, 3, 4, 5]
        let randomResult = random.randomElement()!
        previewFirstImageView.image = UIImage(named: "\(randomResult)")
    }
    
    // 1. ㄴ매개변수 name
    // 2. 보충설명 outletName -> 밖에서 함수 호출할 때 쓰는 이름이랑 함수 내에서 사용하는 변수명이 달라진다.
    // outletName: 외부 매개변수(Argument Label), name: 내부 매개변수(Parameter Name)
    // 3. 외부 매개변수 안쓰기 가능
    // 4. 매개변수 추가(색깔 지정)
    // Parameter(매개변수) : 전달인자를 받을 변수
    func designPreviewImageView(_ name: UIImageView, borderColor: CGColor) {
        name.layer.cornerRadius = 50
        // 타입이 달라서 UIColor에서 CGColor로 바꿔줘야 한다
        name.layer.borderColor = borderColor
        name.layer.borderWidth = 5
        // 얘는 타입이 맞아서 UIColor로 주면 된다
        //firstImageView.backgroundColor = UIColor.blue
        name.backgroundColor = .blue  // 타입이 확실하기 때문에 앞에 UIColor를 생략할 수 있다
        
        //firstImageView.contentMode = UIView.ContentMode.scaleAspectFill
        name.contentMode = .scaleAspectFill   // 얘도 생략할 수 있다
        
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
                randomPlayButton.layer.borderColor = UIColor.red.cgColor
                randomPlayButton.layer.borderWidth = 4
    }
    
    @IBAction func secondPlayButtonClicked(_ sender: UIButton) {
        
        // let random2 = ["극한직업", "도둑들", "명량", "부산행", "신과함께인과연", "베테랑"]
        
        // 인덱스로 접근해서 랜덤으로 뽑는 것도 가능
        let randomResult2 = random2[Int.random(in: 0...random2.count - 1)]
        //let randomResult2 = random2.randomElement()!
        previewSecondImageView.image = UIImage(named: randomResult2)
        
    }
    


}
