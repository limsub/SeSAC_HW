//
//  SeasonCollectionReusableView.swift
//  0818hw
//
//  Created by 임승섭 on 2023/08/18.
//

import UIKit

class SeasonCollectionReusableView: UICollectionReusableView {
    
    
    @IBOutlet var seasonLabel: UILabel!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        seasonLabel.backgroundColor = .systemGray4
    }
    
    
    func designCell(_ sender: Season) {
        seasonLabel.text = "\(sender.name) | \(sender.airDate) | \(sender.voteAverage)"
    }
    

    
}
