//
//  VideoTableViewCell.swift
//  0816hw
//
//  Created by 임승섭 on 2023/08/16.
//

import UIKit
import Kingfisher

class VideoTableViewCell: UITableViewCell {
    
    @IBOutlet var mainImageView: UIImageView!
    
    @IBOutlet var firstLabel: UILabel!
    @IBOutlet var secondLabel: UILabel!
    @IBOutlet var thirdLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func designCell(_ sender: Document) {
        
        let url = URL(string: sender.thumbnail)
        mainImageView.kf.setImage(with: url)
        
        firstLabel.text = sender.title
        secondLabel.text = "\(sender.author) | \(sender.datetime)"
        thirdLabel.text = "\(sender.playTime)"
    }
    
}
