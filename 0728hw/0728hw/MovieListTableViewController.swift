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


enum screenType: Int {
    case all
    case like
}

var data = MovieInfo()

class MovieListTableViewController: UITableViewController {
    
    // 사용하는 배열 : MovieInfo (struct)의 movie. [Movie]
    // 섹션 개수 : 1
    // 셀 개수 : MovieInfo.movie.count
    
    var movies = data.movie
    
    //var data = MovieInfo()
    
    // 즐겨찾기 한 애들의 index 번호만 저장하려고 했는데 tag때문에 꼬일 것 같아서
    // 그냥 통으로 Movie 타입으로 저장해버린다
    //var likeList: [Int] = []    // movie의 인덱스 번호를 저장한다
    var likeList: [Movie] = []
    
    var screen = screenType.all.rawValue      // 0 : 전체 / 1 : 즐겨찾기
    

    

    
    @IBOutlet var pullDownButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designPullDownButton(pullDownButton)
        
        
        // like가 true인 애들 배열에 추가
        for  i in movies {
            if i.like {
                likeList.insert(i, at: 0)
            }
        }
    }
    
    
    // 1. 셀 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    // 2. 셀 데이터 및 디자인
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // MovieListTableViewCell 클래스의 함수를 사용하기 위해 타입 캐스팅
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.identifier) as! MovieListTableViewCell
        
        
        
        
        // 몇 번째인지 -> indexPath.row                  <Int>
        // 어떤 영화인지 -> data.movie[indexPath.row]     <Movie>
        cell.designCell(movies[indexPath.row])
        
        
        
        // 태그 버튼을 indexPath.row로 지정
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        
        
        return cell
    }
    
    @objc
    func likeButtonTapped(_ sender: UIButton) {
        
        movies[sender.tag].like.toggle()
        tableView.reloadData()
        
        
        // 눌러서 true가 되었으면 리스트에 추가해주기
        if (movies[sender.tag].like) {
            likeList.insert(movies[sender.tag], at: 0)
        }
        // 눌러서 false가 되었으면 리스트에서 제거
        
        
        print(likeList)
        
    }
    
    
    
    // pull down button design
    func designPullDownButton(_ sender: UIBarButtonItem) {
        
        // 현재 선택된 옵션을 레이블에 띄워준다
        //sender.setTitle(option, for: .normal)
        
        
        let op1 = UIAction(title: "전체") { _ in
            self.screen = screenType.all.rawValue
            self.movies = data.movie
            self.tableView.reloadData()
            //sender.setTitle(self.option, for: .normal)  // 선택하자마자 바로 업데이트되도록
            
            print(data.movie)
        }
        let op2 = UIAction(title: "즐겨찾기") { _ in
            self.screen = screenType.like.rawValue
            self.movies = self.likeList
            self.tableView.reloadData()
            //sender.setTitle(self.option, for: .normal)
            
            print(data.movie)
        }
        
        let buttonMenu = UIMenu(title: "옵션을 선택하세요", children: [op1, op2])
        
        sender.menu = buttonMenu
    }
    
    

}
