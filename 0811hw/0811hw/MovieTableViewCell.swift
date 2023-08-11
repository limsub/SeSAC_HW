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
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var actorsLabel: UILabel!
    @IBOutlet var lineView: UIView!
    @IBOutlet var detailGoLabel: UILabel!
    @IBOutlet var detailGoButton: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
