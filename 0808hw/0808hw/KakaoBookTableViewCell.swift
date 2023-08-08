//
//  KakaoBookTableViewCell.swift
//  0808hw
//
//  Created by 임승섭 on 2023/08/08.
//

import UIKit
import Kingfisher

class KakaoBookTableViewCell: UITableViewCell {
    
    
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var storyLabel: UILabel!
    
    
    func designCell(_ sender: Book) {
        
        mainImageView.kf.setImage(with: sender.imageUrl)
        titleLabel.text = sender.title
        priceLabel.text = "\(sender.price) -> \(sender.dcPrice) ( \(sender.percent)% 할인 )"
        authorLabel.text = "저자 : \(sender.author) | 출판사 : \(sender.publisher)"
        storyLabel.text = sender.story
    }
}
