//
//  ScrollTestTableViewCell.swift
//  0809hw
//
//  Created by 임승섭 on 2023/08/09.
//

import UIKit

class ScrollTestTableViewCell: UITableViewCell {

    
    @IBOutlet var mainLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainLabel.font = .systemFont(ofSize: 40)
        mainLabel.textAlignment = .center
 
    }
}
