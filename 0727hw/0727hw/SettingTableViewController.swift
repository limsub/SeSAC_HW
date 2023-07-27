//
//  SettingTableViewController.swift
//  0727hw
//
//  Created by 임승섭 on 2023/07/27.
//

import UIKit

class SettingTableViewController: UITableViewController {
    
    
    // 2차원 배열로 선언해서 list[section#][cell#]로 구현해보자
    let settingList = [ ["공지사항", "실험실", "버전 정보"], ["개인/보안", "알림", "채팅", "멀티프로필"], ["고객센터/도움말"]]
    let titleList = ["전체 설정", "개인 설정", "기타"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // 섹션의 개수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return titleList.count
    }
   
    // 섹션의 헤더 이름
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titleList[section]
    }
    
    
    // 1. 셀의 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingList[section].count
    }
    
    // 2. 셀 데이터 및 디자인 처리
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingPage")!    // 옵셔널 주의
        
        cell.textLabel?.text = settingList[indexPath.section][indexPath.row]
        cell.textLabel?.font = .systemFont(ofSize: 15)
        
        return cell
    }
    
    // 3. 셀 높이 -> 디폴트 44로 가자
}
