//
//  MovieListTableViewController.swift
//  0728hw
//
//  Created by 임승섭 on 2023/07/28.
//

import UIKit

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
        
        
        
        
        return cell
    }
    

}
