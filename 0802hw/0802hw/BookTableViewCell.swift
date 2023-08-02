//
//  BookTableViewCell.swift
//  0802hw
//
//  Created by 임승섭 on 2023/08/02.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    var heartCallBackMethod: ( () -> Void )?
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var heartButton: UIButton!
    @IBOutlet var subLabel: UILabel!
    
    func designCell(_ sender: Movie) {
        posterImageView.image = UIImage(named: sender.title)
        posterImageView.contentMode = .scaleAspectFit
        
        titleLabel.text = sender.title
        
        subLabel.text = "\(sender.releaseDate) | \(sender.rate)"
        
        heartButton.setImage(UIImage(systemName: (sender.like) ? "heart.fill" : "heart"),
                             for: .normal)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    @IBAction func heartButtonTapped(_ sender: UIButton) {
        heartCallBackMethod?()
    }
    
    
}
