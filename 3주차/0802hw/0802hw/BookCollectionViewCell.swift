//
//  BookCollectionViewCell.swift
//  0802hw
//
//  Created by 임승섭 on 2023/08/02.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    
    var heartCallBackMethod: ( () -> Void )?

    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var heartButton: UIButton!
    
    
    func designCell(_ sender: Movie) {
        posterImageView.image = UIImage(named: sender.title)
        posterImageView.contentMode = .scaleAspectFit
        
        heartButton.setImage(UIImage(systemName: (sender.like) ? "heart.fill" : "heart"),
                             for: .normal)
    }
    
    
    @IBAction func heartButtonTapped(_ sender: UIButton) {
        heartCallBackMethod?()
    }
    
    
}
