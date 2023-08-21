//
//  MovieTableViewCell.swift
//  0811hw
//
//  Created by 임승섭 on 2023/08/11.
//

import UIKit
import Kingfisher

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
    
    
    @IBOutlet var originalTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainImageView.contentMode = .scaleAspectFill
    
        hashTagLabel.numberOfLines = 2
        
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
        
        hashTagLabel.text = ""
        for txt in sender.genreString {
            hashTagLabel.text! += "#\(txt) "
        }
    
        // 일단 이미지 패스
        titleLabel.text = sender.title
        // 배우 패스
        rateLabel.text = "평정 : \(sender.rate)"
        
        
        let url = URL(string: Endpoint.imagePrefix.requestURL + sender.backImage)
        mainImageView.kf.setImage(with: url)
        
        
        originalTitleLabel.text = sender.originalTitle
        
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
