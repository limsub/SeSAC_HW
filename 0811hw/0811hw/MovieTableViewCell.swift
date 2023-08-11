//
//  MovieTableViewCell.swift
//  0811hw
//
//  Created by 임승섭 on 2023/08/11.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var hashTagLabel: UILabel!
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var actorsLabel: UILabel!
    @IBOutlet var lineView: UIView!
    @IBOutlet var detailGoLabel: UILabel!
    @IBOutlet var detailGoButton: UIButton!
    
    @IBOutlet var backView: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lineView.backgroundColor = .black
    
        

        backView.clipsToBounds = true
        backView.layer.cornerRadius = 20
        backView.layer.borderColor = UIColor.black.cgColor
        backView.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func designCell(_ sender: MovieForMain) {
        dateLabel.text = sender.date
        hashTagLabel.text = "\(sender.genre[0])" // 일단 첫 번째만
        // 일단 이미지 패스
        titleLabel.text = sender.title
        // 배우 패스
        rateLabel.text = "\(sender.rate)"
        
        
    }
    
}


/*
 struct MovieForMain {
     let date: String
     let genre: [String]
     let backImage: String
     let rate: Double
     let title: String
     
 }*/
