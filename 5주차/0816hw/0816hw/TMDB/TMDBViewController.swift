//
//  TMDBViewController.swift
//  0816hw
//
//  Created by 임승섭 on 2023/08/16.
//

import UIKit
import Alamofire


class TMDBViewController: UIViewController {
    
    
    @IBOutlet var tmdbCollectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // self
        tmdbCollectionView.delegate = self
        tmdbCollectionView.dataSource = self
        
        // nib register
        tmdbCollectionView.register(
            UINib(nibName: "EpisodeCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "EpisodeCollectionViewCell"
        )
        tmdbCollectionView.register(
            UINib(nibName: "SeasonCollectionReusableView", bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "SeasonCollectionReusableView"
        )
        
        
        makeLayout()
        callSeason()
    }
    
    var series_id = 1396
    let baseUrl = "https://api.themoviedb.org/3/tv/"
    let header: HTTPHeaders = ["Authorization" : APIKey.tmdb]
    
    var thisSeasons: [Season] = []
    var thisEpisodes: [ [Episode] ] = [[]]
    
    var done: Bool = false
    
    // call Season
    // https://api.themoviedb.org/3/tv/1396?language=ko-KO
    func callSeason() {
        let url = baseUrl + "\(series_id)?language=ko-KO"
        
        AF.request(url, method: .get, headers: header)
            .validate()
            .responseDecodable(of: Tv.self) { response in
                guard let value = response.value else { return }
//                print(response.value)
                self.thisSeasons = value.seasons
//                print(self.thisSeasons)
                
                for i in 0...value.seasons.count-1 { // 시즌이 항상 0부터 시작한다는 보장은 없다...
                    self.callEpisode(i)
                }
                self.done = true
                
                self.tmdbCollectionView.reloadData()
            }
    }
    
    
    
    // call Episode
    // https://api.themoviedb.org/3/tv/1396/season/1?language=ko-KO
    func callEpisode(_ season: Int) {
        let url = baseUrl + "\(series_id)/season/\(season)?language=ko-KO"
        
        AF.request(url, method: .get, headers: header)
            .validate()
            .responseDecodable(of: Tvdetail.self) { response in
                guard let value = response.value else { return }
                print(value)
                
                self.thisEpisodes.append(value.episodes)
                
                self.tmdbCollectionView.reloadData()
            }
    }
    
    

}

extension TMDBViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func makeLayout() {
        
        let spacing:CGFloat = 10
        let width = UIScreen.main.bounds.width
        print(width)

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: width, height: 100)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: width, height: 50)
        
        tmdbCollectionView.collectionViewLayout = layout
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return thisSeasons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return thisSeasons[section].episodeCount
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EpisodeCollectionViewCell", for: indexPath) as? EpisodeCollectionViewCell else { return UICollectionViewCell() }
        
        if thisEpisodes.count == thisSeasons.count &&
            thisEpisodes[indexPath.section].count == thisSeasons[indexPath.section].episodeCount {
            cell.designCell(thisEpisodes[indexPath.section][indexPath.row])
        }
        
        
        
        
        //cell.posterImageView.backgroundColor = .blue
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if (kind == UICollectionView.elementKindSectionHeader) {
            guard let view = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "SeasonCollectionReusableView",
                for: indexPath
            ) as? SeasonCollectionReusableView else { return UICollectionReusableView() }
           
            let name = thisSeasons[indexPath.section].name
            let airDate = thisSeasons[indexPath.section].airDate
            let vote = thisSeasons[indexPath.section].voteAverage
            view.mainLabel.text = "\(name) | \(airDate) | \(vote)"
            
            return view
        }
        
        else {
            return UICollectionReusableView()
        }
    }
}
