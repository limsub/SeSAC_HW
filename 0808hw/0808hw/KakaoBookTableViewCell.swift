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
   
    
    override func awakeFromNib() {
        
        designLabel(titleLabel)
        designLabel(priceLabel)
        designLabel(authorLabel)
    }
    
    func designLabel(_ sender: UILabel) {
        sender.numberOfLines = 0
        sender.font = .systemFont(ofSize: 13)
    }
    
    
    func designCell(_ sender: Book) {
        
        if let url = sender.imageUrl {
            mainImageView.kf.setImage(with: url)
        } else {
            mainImageView.image = UIImage(systemName: "x.square")
        }
        titleLabel.text = sender.title
        priceLabel.text = "\(sender.price) -> \(sender.dcPrice) ( \(sender.percent)% 할인 )"
        authorLabel.text = "저자 : \(sender.author) | 출판사 : \(sender.publisher)"
       
    }
    
}
