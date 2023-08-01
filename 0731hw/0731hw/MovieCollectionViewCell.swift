//
//  MovieCollectionViewCell.swift
//  0731hw
//
//  Created by 임승섭 on 2023/07/31.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet var backView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var heartButton: UIButton!
    
    
    func designCell(_ title: String, _ rate: String, _ like: Bool) {
        
        // 배경 색 랜덤
        // drand48() : [0.0, 1.0) 사이의 값을 반환
        let rRed = CGFloat(drand48())
        let rGreen = CGFloat(drand48())
        let rBlue = CGFloat(drand48())
        let setColor = UIColor(red: rRed, green: rGreen, blue: rBlue, alpha: 1.0)
        backView.backgroundColor = setColor
        
        // 배경 라운드
        backView.layer.cornerRadius = 20
        
        // 영화 종류
        titleLabel.text = title
        rateLabel.text = rate
        posterImageView.image = UIImage(named: title)
        
        // heart 버튼
        heartButton.setImage(UIImage(systemName: (like) ? "heart.fill" : "heart"), for: .normal)
        
    }

}
