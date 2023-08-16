//
//  EpisodeCollectionViewCell.swift
//  0816hw
//
//  Created by 임승섭 on 2023/08/16.
//

import UIKit
import Kingfisher


class EpisodeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var runtimeLabel: UILabel!
    @IBOutlet var overViewLabel: UILabel!
    @IBOutlet var episodeNumLabel: UILabel!
    @IBOutlet var voteLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        overViewLabel.numberOfLines = 0
        makeSmall(titleLabel)
        makeSmall(runtimeLabel)
        makeSmall(overViewLabel)
        makeSmall(episodeNumLabel)
        
        voteLabel.backgroundColor = .white
    }
    
    func makeSmall(_ sender: UILabel) {
        sender.font = .systemFont(ofSize: 13)
    }
    
    func designCell(_ sender: Episode) {
        let url = URL(string: "https://image.tmdb.org/t/p/w600_and_h900_bestv2" + sender.stillPath)
        
        posterImageView.kf.setImage(with: url)
        titleLabel.text = sender.name
        runtimeLabel.text = "\(sender.runtime)"
        overViewLabel.text = sender.overview
        voteLabel.text = "\(sender.voteAverage)"
        episodeNumLabel.text = "\(sender.episodeNumber)"
        
    }

}



/*
"air_date": "2008-01-20",
      "episode_number": 1,
      "episode_type": "standard",
      "id": 62085,
0      "name": "Pilot",
0      "overview": "When an unassuming high school chemistry teacher discovers he has a rare form of lung cancer, he decides to team up with a former student and create a top of the line crystal meth in a used RV, to provide for his family once he is gone.",
      "production_code": "",
      "runtime": 59,
      "season_number": 1,
      "show_id": 1396,
      "still_path": "/ydlY3iPfeOAvu8gVqrxPoMvzNCn.jpg",
      "vote_average": 8.3,
      "vote_count": 315,
*/



/*
 
 "seasons": [
   {
     "air_date": "2009-02-17",
     "episode_count": 11,
     "id": 3577,
     "name": "스페셜",
     "overview": "",
     "poster_path": "/40dT79mDEZwXkQiZNBgSaydQFDP.jpg",
     "season_number": 0,
     "vote_average": 0
   },
   {
     "air_date": "2008-01-20",
     "episode_count": 7,
     "id": 3572,
     "name": "시즌 1",
     "overview": "말기 암 판정을 받은 한 평범한 고등학교 교사가 죽기 전에 가족의 장래를 위한 돈을 마련하기 위해 메타암페타민을 제조하고 유통하려고 한다.",
     "poster_path": "/1BP4xYv9ZG4ZVHkL7ocOziBbSYH.jpg",
     "season_number": 1,
     "vote_average": 8.3
   },
 */
