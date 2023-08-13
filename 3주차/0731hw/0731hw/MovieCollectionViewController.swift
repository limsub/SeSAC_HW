//
//  MovieCollectionViewController.swift
//  0731hw
//
//  Created by 임승섭 on 2023/07/31.
//

import UIKit

// 8/3 homework
// 1. 검색 기능 추가하기
// 2. 상세화면에 placeholder 구현하기





class MovieCollectionViewController: UICollectionViewController {

    // 셀 identifier : MovieCollectionViewCell
    
    // data 모음
    var data = MovieInfo().movie
    let id = "MovieCollectionViewCell"
    
    // 8/3 hw
    var searchData: [Movie] = []
    let searchBar = UISearchBar()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 8/3 hw
        searchBar.delegate = self
        searchBar.placeholder = "검색어를 입력하세요"
        searchBar.showsCancelButton = true
        navigationItem.titleView = searchBar
        
        //title = "영화 책장"
        
        // 등록
        let nib = UINib(nibName: id, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: id)
        
        setCollectionViewLayout()
        
        
        
        // 오른쪽 바 버튼 코드로 구현 -> 왜 안나오냐 이거
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .plain,
            target: self,
            action: #selector(searchButtonTapped)
        )
        navigationItem.rightBarButtonItem?.tintColor = .black
        
        
        // 뒤로가기 버튼 커스텀 - 돌아오는 화면에서 써줘야 한다!!
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
    }
    @objc
    func searchButtonTapped(_ sender: UIBarButtonItem) {
        // 1. 스토리보드 파일 찾기
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        // 2. 뷰컨 찾기
        let vc = sb.instantiateViewController(withIdentifier: "SearchViewController")
        
        // 2 - 1. navigation 상태로 present
        let nav = UINavigationController(rootViewController: vc)
        
        // 3. 전환 방식
        nav.modalPresentationStyle = .fullScreen
        
        // 4. 화면 띄우기
        present(nav, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 1. 스토리보드 파일 찾기
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        // 2. 스토리보드 내 뷰컨
        let vc = sb.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        vc.content = data[indexPath.row].title
        vc.aboutMovie = data[indexPath.row]
        
        // 3. 화면 전환 방식 설정
        
        // 4. 화면 띄우기
        navigationController?.pushViewController(vc, animated: true)
        
        
        
        
    
    }
    
    
    
    
    // 1. 셀 개수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchData.count
    }
    
    // 2. 셀 디자인
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as! MovieCollectionViewCell
        
        cell.designCell(searchData[indexPath.row].title, String(searchData[indexPath.row].rate), searchData[indexPath.row].like, searchData[indexPath.row].backColor)
        
        // heart button
        cell.heartButton.tag = indexPath.row
        cell.heartButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
        

        return cell
    }
    
    @objc
    func heartButtonTapped(_ sender: UIButton) {
        searchData[sender.tag].like.toggle()
        collectionView.reloadData()
    }
    
    
    func setCollectionViewLayout() {
        // * cell estimate size none
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 5
        let width = UIScreen.main.bounds.width - (spacing * 3)
        
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        collectionView.collectionViewLayout = layout
    }
    
}


// 8/3 hw
extension MovieCollectionViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchData.removeAll()
        
        for item in data {
            if item.title.contains(searchBar.text!) {
                searchData.append(item);
            }
        }
        
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchData.removeAll()
        collectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchData.removeAll()
        
        for item in data {
            if item.title.contains(searchBar.text!) {
                searchData.append(item)
            }
        }
        
        collectionView.reloadData()
    }
}
