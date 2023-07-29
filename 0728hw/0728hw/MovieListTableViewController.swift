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

// 7/29 재도전
// 1. data를 불러옴 (전역x)
// 2. 빈 배열 2개 생성 (fullList, likeList) Array<Movie>
// 3. 초기값 추가 (fullList - 전체 / likeLise - true)
// 4. 어떤 변수를 설정하고 왔다갔다 하는 것 보다, 그냥 screenType에 따라 두 배열을 보여주는 쪽으로 하자
// 성공ㅎ



enum screenType: Int {
    case all
    case like
}



class MovieListTableViewController: UITableViewController {
    
    var data = MovieInfo()
    var fullList: [Movie] = []
    var likeList: [Movie] = []
    
    // 사용하는 배열 : MovieInfo (struct)의 movie. [Movie]
    // 섹션 개수 : 1
    // 셀 개수 : MovieInfo.movie.count
    
    
    //var data = MovieInfo()
    
    // 즐겨찾기 한 애들의 index 번호만 저장하려고 했는데 tag때문에 꼬일 것 같아서
    // 그냥 통으로 Movie 타입으로 저장해버린다
    //var likeList: [Int] = []    // movie의 인덱스 번호를 저장한다
    
    
    var screen = screenType.all.rawValue      // 0 : 전체 / 1 : 즐겨찾기
    
    @IBOutlet var pullDownButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designPullDownButton(pullDownButton)
        
        
        // 각 배열 초기화
        for i in data.movie {
            fullList.append(i)
            
            if i.like {
                likeList.append(i)
            }
        }
    }
    
    
    // 1. 셀 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (screen == 0) ? fullList.count : likeList.count
    }
    
    // 2. 셀 데이터 및 디자인
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // MovieListTableViewCell 클래스의 함수를 사용하기 위해 타입 캐스팅
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.identifier) as! MovieListTableViewCell
        
        if ( screen == 0 ) {
            cell.designCell(fullList[indexPath.row])
            cell.likeButton.tag = indexPath.row
            cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        }
        else {
            cell.designCell(likeList[indexPath.row])
            cell.likeButton.tag = indexPath.row
            cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        }
        
        
        
        
//        // 몇 번째인지 -> indexPath.row                  <Int>
//        // 어떤 영화인지 -> data.movie[indexPath.row]     <Movie>
//        cell.designCell(movies[indexPath.row])
//
//
//
//        // 태그 버튼을 indexPath.row로 지정
//        cell.likeButton.tag = indexPath.row
//        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        
        
        return cell
    }
    
    @objc
    func likeButtonTapped(_ sender: UIButton) {
        
        if (screen == 0) {
            fullList[sender.tag].like.toggle()
            makeLikeList()
            tableView.reloadData()
        }
        else {
            // 즐겨찾기 창에 나온 영화들은 일단 like가 모두 true
            // 눌렀다는 건 해제한다는 뜻
            // 해당 영화를 fullList에서 찾아서 like를 false로 바꿔주고 makeLikeList() 호출
            
            let title = likeList[sender.tag].title
            
            for i in 0...fullList.count-1 {
                if fullList[i].title == title {
                    fullList[i].like = false;
                }
            }
            
            makeLikeList()
            tableView.reloadData()
        }
    }
    
    
    
    // pull down button design
    func designPullDownButton(_ sender: UIBarButtonItem) {
        
        // 현재 선택된 옵션을 레이블에 띄워준다
        //sender.setTitle(option, for: .normal)
        
        
        let op1 = UIAction(title: "전체") { _ in
            self.screen = screenType.all.rawValue
            self.tableView.reloadData()
        }
        let op2 = UIAction(title: "즐겨찾기") { _ in
            self.screen = screenType.like.rawValue
            self.tableView.reloadData()
        }
        
        let buttonMenu = UIMenu(title: "옵션을 선택하세요", children: [op1, op2])
        
        sender.menu = buttonMenu
    }
    
    
    // fullList에서 likeList를 추출하는 함수
    func makeLikeList() {
        likeList.removeAll()
        
        for m in fullList {
            if m.like {
                likeList.append(m)
            }
        }
    }

}
