//
//  MovieListTableViewController.swift
//  0728hw
//
//  Created by 임승섭 on 2023/07/28.
//

import UIKit


// 과제 +
// 즐겨찾기 한 리스트만 따로 보게 하기
// 1. pull down button (1. 전체 / 2. 즐겨찾기)
// 2. cell의 우측 상단에 별 버튼
//      2 - 1. 선택하면 즐겨찾기 배열에 추가 -> index로 할 지?
//      2 - 2. 취소하면 즐겨찾기에서 제외 -> index를 어떻게 저장하냐. 딕셔너리?

class MovieListTableViewController: UITableViewController {
    
    // 사용하는 배열 : MovieInfo (struct)의 movie. [Movie]
    // 섹션 개수 : 1
    // 셀 개수 : MovieInfo.movie.count
    
    var data = MovieInfo()
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 1. 셀 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.movie.count
    }
    
    // 2. 셀 데이터 및 디자인
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // MovieListTableViewCell 클래스의 함수를 사용하기 위해 타입 캐스팅
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.identifier) as! MovieListTableViewCell
        
        
        
        
        // 몇 번째인지 -> indexPath.row                  <Int>
        // 어떤 영화인지 -> data.movie[indexPath.row]     <Movie>
        cell.designCell(data.movie[indexPath.row])
        
        
        
        // 태그 버튼을 indexPath.row로 지정
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        
        
        return cell
    }
    
    @objc
    func likeButtonTapped(_ sender: UIButton) {
        
        data.movie[sender.tag].like.toggle()
        tableView.reloadData()
        
        
    }
    

}
