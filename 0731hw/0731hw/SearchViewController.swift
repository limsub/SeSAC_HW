//
//  SearchViewController.swift
//  0731hw
//
//  Created by 임승섭 on 2023/07/31.
//

import UIKit

extension SearchViewController: UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if self.isFiltering {
            cell.textLabel?.text = self.filteredArr[indexPath.row]
        }
        else {
            cell.textLabel?.text = self.arr[indexPath.row]
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.isFiltering {
            return self.filteredArr.count
        }
        else {
            return self.arr.count
        }
        
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        // 영어 검색할 수도 있으니까 lowercased
        guard let text = searchController.searchBar.text?.lowercased() else {return}
        self.filteredArr = self.arr.filter { $0.lowercased().contains(text) }
        
        
        
        self.movieTableView.reloadData()
        
    }
}

class SearchViewController: UIViewController {
    
    
    @IBOutlet weak var movieTableView: UITableView!
    
    var arr: [String] = [];
    
    // var arr = ["Zedd", "Alan Walker", "David Guetta", "Avicii", "Marshmello", "Steve Aoki", "R3HAB", "Armin van Buuren", "Skrillex", "Illenium", "The Chainsmokers", "Don Diablo", "Afrojack", "Tiesto", "KSHMR", "DJ Snake", "Kygo", "Galantis", "Major Lazer", "Vicetone"]
    
    var filteredArr: [String] = []
    
    
    
    // 고려해야 하는 것 : searchBar가 활성화 되어 있는지, text가 입력이 되어있는지
    var isFiltering: Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
        
        return isActive && isSearchBarHasText
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for m in MovieInfo().movie {
            arr.append(m.title)
        }

        title = "검색 화면"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .plain,
            target: self,
            action: #selector(closeButtonTapped)
        )
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        
        
        setupSearchController()
        setupTableView()
    }
    
    
    
    // set up search controller
    func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        
        // text가 업데이트될 때마다 불리는 메소드
        searchController.searchResultsUpdater = self
    }
    // set up tableview
    func setupTableView() {
        self.movieTableView.delegate = self
        self.movieTableView.dataSource = self
    }
    
    @objc
    func closeButtonTapped() {
        dismiss(animated: true)     // present로 왔기 때문에 dismiss
    }
    

}
