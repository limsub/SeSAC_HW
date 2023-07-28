//
//  MovieListTableViewCell.swift
//  0728hw
//
//  Created by 임승섭 on 2023/07/28.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {
    
    static let identifier = "MovieListTableViewCell"
    
    @IBOutlet var moviePoster: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subLabel: UILabel!
    @IBOutlet var storyLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    
    // 2. 셀 데이터 및 디자인
    func designCell(_ row: Movie) {
        
        // (1). 이미지
        moviePoster.image = UIImage(named: row.title)
        
        // (2). 제목
        titleLabel.text = row.title
        titleLabel.font = .boldSystemFont(ofSize: 20)
        
        // (3). 부가 정보
        subLabel.text = "\(row.releaseDate) | \(row.runtime)분 | \(row.rate)점"
        subLabel.font = .systemFont(ofSize: 17)
        
        // (4). 줄거리
        storyLabel.text = row.overview
        storyLabel.numberOfLines = 5
        storyLabel.font = .systemFont(ofSize: 13)
        
        // (5). 버튼
        likeButton.setImage(UIImage(systemName:
                                        (row.like) ? "star.fill" : "star"), for: .normal)
    }
    
    
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        
        //data[sender.tag].like
        
    }
    
}
