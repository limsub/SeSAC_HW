//
//  SearchForCollectionCellViewController.swift
//  0731hw
//
//  Created by 임승섭 on 2023/07/31.
//

import UIKit


extension SearchForCollectionCellViewController: UICollectionViewDelegate, UICollectionViewDataSource, UISearchResultsUpdating {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.id, for: indexPath) as! MovieCollectionViewCell
        
        if self.isFiltering {
            cell.designCell(filteredArr[indexPath.row].title, String(filteredArr[indexPath.row].rate), filteredArr[indexPath.row].like, arr[indexPath.row].backColor)
        }
        else {
            cell.designCell(arr[indexPath.row].title, String(arr[indexPath.row].rate), arr[indexPath.row].like, arr[indexPath.row].backColor)
        }

        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.isFiltering {
            return self.filteredArr.count
        }
        else {
            return self.arr.count
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text?.lowercased() else { return }
        self.filteredArr = self.arr.filter {$0.title.lowercased().contains(text)}
        
        self.movieCollectionView.reloadData()
    }
    
}

class SearchForCollectionCellViewController: UIViewController {
    
    
    
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    let id = "MovieCollectionViewCell"
    
    var arr: [Movie] = [];
    var filteredArr: [Movie] = [];
    
    var isFiltering: Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
        
        return isActive && isSearchBarHasText
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: id, bundle: nil)
        movieCollectionView.register(nib, forCellWithReuseIdentifier: id)

        for m in MovieInfo().movie {
            arr.append(m)
        }
        
        title = "collection 검색 화면"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .plain,
            target: self,
            action: #selector(closeButtonTapped)
        )
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        setupCollectionView()
        setupSearchController()
    }
    
    // setup
    func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        
        searchController.searchResultsUpdater = self
    }
    
    func setupCollectionView() {
        self.movieCollectionView.delegate = self
        self.movieCollectionView.dataSource = self
    }
    
    
    @objc
    func closeButtonTapped() {
        dismiss(animated: true)     // present로 왔기 때문에 dismiss
    }

    
    func setCollectionViewLayout() {
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let width = UIScreen.main.bounds.width - (spacing * 2)
        
        layout.itemSize = CGSize(width: width, height: 10)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        movieCollectionView.collectionViewLayout = layout
    }


}
