//
//  BookViewController.swift
//  0802hw
//
//  Created by 임승섭 on 2023/08/02.
//



import UIKit

// 셀 연결
    // 1. 셀 파일 생성 (xib)
    // 1.5 셀 디자인
    // 2. 셀 identifier 설정
    // 3. 셀 등록 (nib)

// 테이블뷰/컬렉션뷰
    // 1. 프로토콜 상속
    // 2. 연결 ( = self)
    // 3. 아웃렛 연결



// 8/2 과제
// 1. 최근 본 작품 -> 좋아하는 작품
    // 오늘은 배열 새로 만드는 거 말고 filter 써서 해보자
    // 근데 매번 filter 쓰는 게 낫냐 아니면 배열 하나 만들어서 그거 쓰는게 낫냐


// 기능 정리
// 1. 위는 collectionView, 아래는 tableView
// 2. tableView의 헤더에 collectionView
// 3. tableView에는 모든 데이터, collectionView에는 좋아요 누른 데이터

class BookViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet var bookCollectionView: UICollectionView!
    @IBOutlet var bookTableView: UITableView!
    
    // 데이터 저장
    var data = MovieInfo().movie
    
    /* tableView */
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "요즘 인기 작품"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.BookTableViewCell.rawValue) as! BookTableViewCell
        
        cell.designCell(data[indexPath.row])
        
        // (tableView) 좋아요 버튼을 눌렀을 때 -> data의 해당 요소 toggle
        cell.heartCallBackMethod = { [weak self] in
            self?.data[indexPath.row].like.toggle()
            
            self?.bookTableView.reloadData()
            self?.bookCollectionView.reloadData()
        }
        
        return cell
    }
    
    /* collectionView */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.filter { $0.like }.count    // filter 이용
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.BookCollectionViewCell.rawValue, for: indexPath) as! BookCollectionViewCell
        
        cell.designCell(data.filter { $0.like }[indexPath.row] )
        
        cell.heartCallBackMethod = { [weak self] in
            // 배열을 따로 안만들어서 여기서 좀 막힌다
            // 현재 여기 있는 애들은 filter를 거쳐서 나온 새로운 배열.
            // 여기서의 indexPath로 기존 배열에 접근해야 하는데 불가능
            
            // 일단 방법 1. 현재 요소의 제목을 따로 저장해서 기존 배열에 맞는 제목을 검색해서 찾음... (시간적으로 아주 비효율적)
            // struct 끼리도 == 연산 사용 가능한가?
            
            let title = self?.data.filter{ $0.like }[indexPath.row].title // 아직 좋아요가 토글되기 전 좋아요 배열에서 해당 영화의 타이틀
            
            for i in 0...(self?.data.count)! - 1 {
                if title == self?.data[i].title {
                    self?.data[i].like.toggle()
                }
            }
            
//            // 아니 얘는 왜안되냐 -> 되네?
//            for var m in (self?.data)! {
//                if title == m.title {
//                    m.like.toggle()
//                }
//            }
            // 이렇게 하면 아무 의미없는 코드가 되어버림;;
            
            
            self?.bookCollectionView.reloadData()
            self?.bookTableView.reloadData()
            
            self?.configureCollectionViewLayout()
        }
        return cell
    }
    
    // 셀 선택 시 상세화면으로
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1 + 2. 같은 스토리보드 내 뷰컨
        let vc = storyboard?.instantiateViewController(withIdentifier: Cell.DetailViewController.rawValue) as! DetailViewController
        
        vc.contents = data[indexPath.row]
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: Cell.DetailViewController.rawValue) as! DetailViewController
        
        vc.contents = data.filter{ $0.like }[indexPath.row]
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 등록
        let nib = UINib(nibName: Cell.BookTableViewCell.rawValue, bundle: nil)
        bookTableView.register(nib, forCellReuseIdentifier: Cell.BookTableViewCell.rawValue)
        
        let nib2 = UINib(nibName: Cell.BookCollectionViewCell.rawValue, bundle: nil)
        bookCollectionView.register(nib2, forCellWithReuseIdentifier: Cell.BookCollectionViewCell.rawValue)
        
        // 프로토콜 연결
        bookCollectionView.dataSource = self
        bookCollectionView.delegate = self
        
        bookTableView.dataSource = self
        bookTableView.delegate = self
        
        configureCollectionViewLayout()
        bookTableView.rowHeight = 150
    }
    
    
    
    // configure cell
    func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height : 150)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        bookCollectionView.collectionViewLayout = layout
    }
}
