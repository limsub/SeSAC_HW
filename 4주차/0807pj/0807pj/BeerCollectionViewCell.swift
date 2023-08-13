//
//  BeerCollectionViewCell.swift
//  0807pj
//
//  Created by 임승섭 on 2023/08/08.
//

import UIKit
import Kingfisher

class BeerCollectionViewCell: UICollectionViewCell {


    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.numberOfLines = 0
        descriptionLabel.numberOfLines = 3
        
        nameLabel.font = .systemFont(ofSize: 11)
        descriptionLabel.font = .systemFont(ofSize: 10)
    }
    
    func designCell(_ sender: Beer) {
        
        if let url = sender.imageUrl {
            mainImageView.kf.setImage(with: url)
        } else {
            mainImageView.image = UIImage(systemName: "x.square")
        }
        
        nameLabel.text = "이름 : \(sender.name)"
        descriptionLabel.text = "설명 : \(sender.description)"
    }
    
}

