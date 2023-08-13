//
//  ShoppingTableViewController.swift
//  0727hw
//
//  Created by 임승섭 on 2023/07/27.
//

import UIKit

// extension으로 textfield 시작하는 부분에 padding 넣어주는 함수 추가하기
extension UITextField {
    
  func addLeftPadding() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
}



class ShoppingTableViewController: UITableViewController {
    
    
    /* 텍스트필드에 입력 후 추가 버튼을 누르면 cell이 추가되는 페이지*/
    // 1. 텍스트필드에 제대로 입력되었는지 확인 -> nil이거나 빈글자는 x
    // 2. pull down 버튼을 넣어서 섹션을 구분해볼까
        // 2 - 1. 섹션도 계속 추가하는건 어려우니까 섹션은 고정시켜두자
        // 2 - 2. 선택한 섹션이 레이블로 떠있게 해주기
    // 3. 섹션 별 cell들을 배열로 저장 -> 총 하나의 dictionary로 관리
    // 4. 가장 최근에 추가한게 맨 위에 뜨게 하기
        // 4 - 1. 배열의 맨 앞에 추가하기 (insert?)
    
    
    // pull down button
    // textlabel에 현재 선택된 type 띄우고, 오른쪽에 아래화살표 이미지
    // 누르면 pull down으로 옵션 선택할 수 있게
    @IBOutlet var pulldownButton: UIButton!
    @IBOutlet var shoppingTextField: UITextField!
    @IBOutlet var addButton: UIButton!
    
    @IBOutlet var searchView: UIView!
    
    
    
    // 현재 선택된 옵션 -> 선언만 해두고 초기값은 viewDidLoad에서 typeList[0]로 잡아주자
    // 려고 했는데 저장속성 초기화 안하면 안되니까 그냥 "일반"으로 해주자
    var option: String = "일반"
    
    
    // 현재 저장된 값들 -> 딕셔너리
    var shoppingDict: [String: [String]]
        = ["일반" : [], "음식" : [], "옷" : [] ]
    // 타입 -> 배열
    let typeList = ["일반", "음식", "옷"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 디자인
        searchView.backgroundColor = .systemGray5
        searchView.layer.cornerRadius = 10
        
        pulldownButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        pulldownButton.semanticContentAttribute = .forceRightToLeft
        pulldownButton.tintColor = .black
        
        shoppingTextField.backgroundColor = .systemGray5
        shoppingTextField.placeholder = "추가할 항목을 입력하세요"
        shoppingTextField.borderStyle = .none
        shoppingTextField.addLeftPadding()
        
        addButton.tintColor = .black
        addButton.layer.cornerRadius = 10
        addButton.layer.backgroundColor = UIColor.systemGray4.cgColor

        
        // 초기 옵션
        option = typeList[0]
        
        // pull down button
        designPullDownButton(pulldownButton)
    }
    
    // 섹션의 개수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return shoppingDict.keys.count
    }
    
    // 섹션의 헤더 이름
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return typeList[section]
    }
    
    // 1. 셀의 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 배열에서 먼저 찾고, dictionary에서 찾기
        return shoppingDict[typeList[section]]!.count
    }
    
    // 2. 셀 디자인 및 데이터 처리
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingPage")!
        // 먼저 섹션의 이름을 찾고,
        let t = typeList[indexPath.section]
        // 해당 섹션에 해당하는 배열의 요소를 찾는다
        cell.textLabel?.text = shoppingDict[t]![indexPath.row]
        
        return cell
    }
    
    
    
    // pull down button design
    func designPullDownButton(_ sender: UIButton) {
        
        // 현재 선택된 옵션을 레이블에 띄워준다
        sender.setTitle(option, for: .normal)
        
        
        let op1 = UIAction(title: "일반") { _ in
            self.option = self.typeList[0]
            sender.setTitle(self.option, for: .normal)  // 선택하자마자 바로 업데이트되도록
        }
        let op2 = UIAction(title: "음식") { _ in
            self.option = self.typeList[1]
            sender.setTitle(self.option, for: .normal)
        }
        let op3 = UIAction(title: "옷") { _ in
            self.option = self.typeList[2]
            sender.setTitle(self.option, for: .normal)
        }
        let buttonMenu = UIMenu(title: "옵션을 선택하세요", children: [op1, op2, op3])
        
        sender.menu = buttonMenu
    }
    
    
    // textField에 잘 써있는지 확인
    func checkTextField(_ sender: UITextField) -> Bool {
        if let txt = sender.text {
            if txt.count >= 1 {
                return true
            }
        }
        
        // nil이거나 count가 0이면 false를 리턴한다
        return false
    }
    
    // return / 추가 버튼 클릭 시 실행
    func updateList() {
        // 1. 텍스트필드에 정상적으로 써있는지 확인
        if (checkTextField(shoppingTextField)) {
            let txt = shoppingTextField.text!   // 함수 통과했으니까 강제 언래핑 해주기
            
            // 2. 현재 선택된 옵션에 해당하는 배열에 추가해주기. 추가할 때 맨 앞에 추가 - insert 사용
            shoppingDict[option]?.insert(txt, at: 0)
            
            // 3. 화면 다시 로드
            tableView.reloadData()
            
            // 4. textfield 초기화
            shoppingTextField.text = ""
            
        }
        // 1 - 1. 텍스트필드 제대로 쓰라고 alert
        else {
            let alert = UIAlertController(title: "텍스트가 올바르지 않습니다", message: "다시 써주세요", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default)
            alert.addAction(ok)
            present(alert, animated: true)
        }
    }
    
    
    // 기본 설정
    // return 키 눌렀을 때 추가 버튼과 동일하게 동작 / 키보드 내려가기
    // 배경 터치 시 키보드 내려가기
    
    /* IBAction */
    // 추가 버튼 클릭
    @IBAction func addButtonTapped(_ sender: UIButton) {
        updateList()
    }
    
    // 리턴 버튼 클릭
    @IBAction func returnKeyTapped(_ sender: UITextField) {
        updateList()
    }
    
    
    // tap gesture 올릴 때 view controller랑 다르다 -> 기능도 다른게 있는지 확인하기
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // cell에 tapgesture을 얹으면 맨 위에 있는 Cell에만 적용된다
    // table view의 scroll view의 keyboard dismiss on drag
    @IBAction func tapGestuerCell(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    
    
    // 시간 씀
    // pull down button 말고 그냥 button으로 추가해줬을 땐 옵션들이 안나왔는데
    // pull down button으로 땡겨오니까 정상적으로 나옴
}
