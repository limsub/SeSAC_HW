//
//  SeasonCollectionReusableView.swift
//  0816hw
//
//  Created by 임승섭 on 2023/08/16.
//

import UIKit


class SeasonCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet var mainLabel: UILabel!
    // name, air date, vote average
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainLabel.backgroundColor = .systemGray5
    }
    
}
