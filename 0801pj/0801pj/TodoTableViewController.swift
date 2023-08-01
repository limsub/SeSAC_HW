//
//  TodoTableViewController.swift
//  0801pj
//
//  Created by 임승섭 on 2023/08/01.
//

import UIKit


// 8/1
// 1. 투두리스트 만들기
//(0) 2. 왼쪽 : done 버튼 / 오른쪽 : 즐겨찾기 버튼
    // 2 - 1. done 누르면 없어지기 -> pull down 버튼으로 확인 가능
        // 현재 있는 배열(즐 or 일)에서 제거하고 done 배열에 추가하기
        // 는 너무 어려울 것 같다 (tableView를 아예 갈아 엎어야 함)
        // done 버튼 누르면 현재 배열에서 가장 뒤로 움직이도록 하자
    // 2 - 2. 즐겨찾기 섹션, 일반 섹션 따로 나눠서 버튼 누르면 왔다갔다 하기

//(0) 3. 데이터 추가 (pull down button, textfield, ok버튼)
//(0) 4. 데이터 검색 (search bar)

//(0) 셀은 다른 파일에서 구현하는 연습 (XIB 파일)
// 셀 안에 레이블 말고 텍스트 뷰로 해서 수정도 가능하게 해보기
    // 여러 줄 안되게 하기
    // 엔터치면 끝
//(0) identifier같은건 enum으로 써보는 연습
// 가능하면 커스텀 스와이프도 해보기
//(0) done이면 그냥 그 버튼은 끝 -> 버튼, textview 모두 수정 불간으




extension TodoTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let txt = searchController.searchBar.text?.lowercased() else { return }
        
        self.filteredList.specialList = self.list.specialList.filter{ $0.main.lowercased().contains(txt) }
        self.filteredList.todoList = self.list.todoList.filter{
            $0.main.lowercased().contains(txt) }
        
        
        
        self.tableView.reloadData()
    }
    
    
}


class TodoTableViewController: UITableViewController {
    
    // 투두 리스트 (즐겨찾기, 일반 따로) -> 하나의 클래스에 만듬
    var list = ToDoInformation()
        // 얜 뭐지...
//        didSet {
//            tableView.reloadData()
//        }
    
    var filteredList = ToDoInformation()
    
    var isFiltering: Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
        
        print(isActive && isSearchBarHasText)
        
        return isActive && isSearchBarHasText
    }
    
    // setup
    func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        
        searchController.searchResultsUpdater = self
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    
    
    
    
    
    @IBOutlet var todoSearchBar: UISearchBar!
    
    @IBOutlet var pullDownButton: UIButton!
    @IBOutlet var newTextField: UITextField!
    @IBOutlet var okButton: UIButton!
    
    var option = Option.일반.rawValue


    override func viewDidLoad() {
        super.viewDidLoad()

        // nib 등록
        let nib = UINib(nibName: identifier.TodoTableViewCell.rawValue, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: identifier.TodoTableViewCell.rawValue)
        
        // pull down button 디자인
        designPullDownButton(pullDownButton)
        
        // setup
        setupTableView()
        setupSearchController()
    }
    
    // 0. 섹션 개수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // 0.5 섹션 헤더 이름
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (section == 0) ? "즐겨찾기" : "일반"
    }
    
    // 1. 셀 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (section == 0) {
            if (isFiltering) {
                return filteredList.specialList.count
            } else {
                return list.specialList.count
            }
        }
        else {
            if (isFiltering) {
                return filteredList.todoList.count
            } else {
                return list.todoList.count
            }
        }
        
        
        return (section == 0) ? list.specialList.count : list.todoList.count
    }
    
    // 2. 셀 데이터 및 디자인
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier.TodoTableViewCell.rawValue) as! TodoTableViewCell
        
        
        if (indexPath.section == 0 /*&& !list.specialList.isEmpty*/) {
            if (isFiltering) {
                let row = filteredList.specialList[indexPath.row]  // type : ToDo
                cell.designCell(row)
            }
            else {
                let row = list.specialList[indexPath.row]  // type : ToDo
                cell.designCell(row)
            }
        }
        else if (indexPath.section == 1 /*&& !list.todoList.isEmpty*/ ){
            if (isFiltering) {
                let row = filteredList.todoList[indexPath.row]
                cell.designCell(row)
            }
            else {
                let row = list.todoList[indexPath.row]
                cell.designCell(row)
            }
        }
        
        
        
        
        // 버튼 기능 (섹션 구분을 어떻게 해줘야 할까) -> 클로저를 이용하는 방법
        // 문제는, 얘가 먼저 실행되고 위에 애들이 실행되기 때문에, indexPath.row 부분에서 문제가 생긴다 <- 수동으로 작업해주자 (나중에 질문하기)
        // 1. done Button
        cell.doneCallBackMethod = { [weak self] in
            
            // 누르는것만 작동하게 할거다. 취소 불가능
            if (indexPath.section == 0 && !((self?.list.specialList[indexPath.row].done)!)  ) {
                var tmp: ToDo = (self?.list.specialList[indexPath.row])!

                self?.list.specialList.remove(at: indexPath.row)
                
                tmp.done = true;
                
                self?.list.specialList.insert(tmp, at: (self?.list.specialList.count)!)
            }
            else if (indexPath.section == 1 && !((self?.list.todoList[indexPath.row].done)!)  ) {
                var tmp: ToDo = (self?.list.todoList[indexPath.row])!

                self?.list.todoList.remove(at: indexPath.row)
                
                tmp.done = true;
                
                self?.list.todoList.insert(tmp, at: (self?.list.todoList.count)!)
            }
            
            tableView.reloadData()
        }
        
        // 2. special Button (indexPath.section
        // 이미 done이면 이것도 작동 못함
        cell.specialCallBackMethod = { [weak self] in

            if (indexPath.section == 0 && !((self?.list.specialList[indexPath.row].done)!)) {   // 즐겨찾기 버튼이 눌러져 있다 (special == true)
                // specialList에서 빼고 todoList로 넣어준다
                var tmp: ToDo = (self?.list.specialList[indexPath.row])!

                self?.list.specialList.remove(at: indexPath.row)
                
                tmp.special = false;
                
                self?.list.todoList.insert(tmp, at: 0)
            }
            else if (indexPath.section == 1 && !((self?.list.todoList[indexPath.row].done)!)) {  // 즐겨찾기 버튼이 안눌러져 있다 (special == false)
                var tmp: ToDo = (self?.list.todoList[indexPath.row])!

                self?.list.todoList.remove(at: indexPath.row)

                tmp.special = true
                
                self?.list.specialList.insert(tmp, at: 0)
            }
            
            tableView.reloadData()
        }
        
        
        
        return cell
    }

    
    
    
    
    // design
    func designPullDownButton(_ sender: UIButton) {
        
        sender.setTitle(option, for: .normal)
        
        let op1 = UIAction(title: Option.즐겨찾기.rawValue) { _ in
            self.option = Option.즐겨찾기.rawValue
            sender.setTitle(self.option, for: .normal)
        }
        
        let op2 = UIAction(title: Option.일반.rawValue) { _ in
            self.option = Option.일반.rawValue
            sender.setTitle(self.option, for: .normal)
        }
        
        let buttonMenu = UIMenu(title: "선택", children: [op1, op2])
        
        sender.menu = buttonMenu
    }
    
    // check textfield
    func checkTextField(_ sender: UITextField) -> Bool {
        if let txt = sender.text {
            if txt.count >= 1 {
                return true
            }
        }
        
        return false
    }
    
    // update List
    func updateList() {
        if (checkTextField(newTextField)) {
            let txt = newTextField.text!
            
            if option == Option.일반.rawValue {
                list.todoList.insert(ToDo(done: false, main: txt, special: false), at: 0)
                
                tableView.reloadData()
                
                newTextField.text = ""
            }
            else if option == Option.즐겨찾기.rawValue {
                list.specialList.insert(ToDo(done: false, main: txt, special: true), at: 0)
                
                tableView.reloadData()
                
                newTextField.text = ""
                
            }
        }
        else {
            let alert = UIAlertController(title: "텍스트가 올바르지 않습니다", message: "다시 써주세요", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default)
            alert.addAction(ok)
            present(alert, animated: true)
        }

    }
    
    
    @IBAction func textfieldReturnTapped(_ sender: UITextField) {
        updateList()
    }
    
    @IBAction func okButtonTapped(_ sender: UIButton) {
        updateList()
        view.endEditing(true)
    }
    
    
    
}
