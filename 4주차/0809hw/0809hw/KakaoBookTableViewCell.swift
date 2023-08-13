//
//  KakaoBookTableViewCell.swift
//  0809hw
//
//  Created by 임승섭 on 2023/08/09.
//

import UIKit

class KakaoBookTableViewCell: UITableViewCell {

    
    
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var firstLabel: UILabel!
    @IBOutlet var secondLabel: UILabel!
    @IBOutlet var thirdLabel: UILabel!
    @IBOutlet var fourthLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        firstLabel.font = .systemFont(ofSize: 15)
        secondLabel.font = .systemFont(ofSize: 13)
        thirdLabel.font = .systemFont(ofSize: 13)
        fourthLabel.font = .systemFont(ofSize: 13)
        
        firstLabel.numberOfLines = 2
        secondLabel.numberOfLines = 2
        thirdLabel.numberOfLines = 2
        fourthLabel.numberOfLines = 2

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
