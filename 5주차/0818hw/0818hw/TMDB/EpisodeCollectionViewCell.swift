//
//  EpisodeCollectionViewCell.swift
//  0818hw
//
//  Created by 임승섭 on 2023/08/18.
//

import UIKit
import Kingfisher

class EpisodeCollectionViewCell: UICollectionViewCell {

    
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var overViewLabel: UILabel!
    @IBOutlet var voteLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = .systemFont(ofSize: 13)
        contentLabel.font = .systemFont(ofSize: 13)
        overViewLabel.font = .systemFont(ofSize: 13)
        
        overViewLabel.numberOfLines = 0
        voteLabel.backgroundColor = .white
    }
    
    func designCell(_ sender: Episode) {
        posterImageView.kf.setImage(with: URL.makeImageUrl(sender.stillPath))
        titleLabel.text = sender.name
        contentLabel.text = String(sender.runtime)
        overViewLabel.text = sender.overview
        voteLabel.text = String(sender.voteAverage)
    }
    
    

}
