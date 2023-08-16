//
//  VideoViewController.swift
//  0816hw
//
//  Created by 임승섭 on 2023/08/16.
//

import UIKit

class VideoViewController: UIViewController {
    
    // 비디오 목록
    var videoList: [Document] = []
    

    @IBOutlet var videoSearchBar: UISearchBar!
    // 1. 프로토콜 채택 + self
    @IBOutlet var videoTableView: UITableView!
    // 1. 프로토콜 채택 + self
    // 2. 셀 등록 (nib)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // self
        videoSearchBar.delegate = self
        videoTableView.delegate = self
        videoTableView.dataSource = self
        
        // nib
        let nib = UINib(nibName: "VideoTableViewCell", bundle: nil)
        videoTableView.register(nib, forCellReuseIdentifier: "VideoTableViewCell")
        
        // rowHeight
        videoTableView.rowHeight = 150
        
        // dismiss on drag
        videoTableView.keyboardDismissMode = .onDrag
    }
    
    func callRequest(query: String) {
        APIManager.shared.callRequest(type: .video, query: query) { response in
            print(response)
            print(type(of: response))
            
            self.videoList = response.documents
            
            self.videoTableView.reloadData()
        }
    }
}

extension VideoViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let query = searchBar.text else { return }
        callRequest(query: query)
    }
    
}


extension VideoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell") as? VideoTableViewCell else { return UITableViewCell() }
        
        cell.designCell(videoList[indexPath.row])
        
        
        return cell
    }
    
    
}
