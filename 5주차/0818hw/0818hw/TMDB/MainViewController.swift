//
//  MainViewController.swift
//  0818hw
//
//  Created by 임승섭 on 2023/08/18.
//

import UIKit


// 1. tv 정보 -> season이 몇개인지, season별 정보
// 2. 시즌 정보 -> 에피소드 몇개인지, 에피소드별 정보

// 문제 : season이 몇개인지 알 수가 없음.
// 1에서 api 받으면, 그 결과를 보고 배열의 크기를 정해야 할 듯 싶다.. -> for문 돌면서 append(빈구조체)
// 일단 처음은 빈 배열로 해야 할듯


// 브레이킹 배드처럼 시즌 배열 맨 처음에 스페셜 있는건 버리자


class MainViewController: UIViewController {
    
    @IBOutlet var mainSearchBar: UISearchBar!
    @IBOutlet var mainCollectionView: UICollectionView!
    
    var seasonInfo: Tv?
    var episodeInfo: [Tvdetail] = []
    
    var seriesId = 1396
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchBar()
        configureCollectionView()
        configureCollectionViewLayout()
        
        callSeasonRequest(seriesId)
    }
    
    
    func callSeasonRequest(_ seriesId: Int) {
        TmdbAPIManager.shared.callSeason(seriesId) { value in
            self.seasonInfo = value
            
            print(value.seasons)
            
            print("====================================")
            print(self.seasonInfo?.numberOfSeasons) // 5 -> 이걸로 가자 (x)
            print(self.seasonInfo?.seasons.count)   // 6 -> 이걸로 간다 (x) (o)
            
            guard let seasonCnt = self.seasonInfo?.seasons.count else { return }
            
            // episodeInfo의 크기를 잡아줌.. (맞는건지 잘 모르겠다)
            for _ in 1...seasonCnt {
                self.episodeInfo.append(Tvdetail(id: "", airDate: "", episodes: [], name: "", overview: "", tvdetailID: 0, posterPath: "", seasonNumber: 0, voteAverage: 0))
            }
            
            
            print("=====================")
            
            // epsiode에 대한 정보 호출 (0 넣어주면 안되는 것 같다...왜지..?)
            let group = DispatchGroup()
            
            guard let allSeasons = self.seasonInfo?.seasons else { return }
            for item in allSeasons {
                group.enter()
                print(item.seasonNumber)
                self.callEpisodeRequest(seriesId, item.seasonNumber) {
                    group.leave()
                }
            }
           
            
            group.notify(queue: .main) {
                print("end")
                
                self.mainCollectionView.reloadData()
            }
            
        }
    }
    
    func callEpisodeRequest(_ seriesId: Int, _ season: Int, completionHandler: @escaping ()-> Void ) { // 여기서의 season은 인덱스라고 생각
        TmdbAPIManager.shared.callEpisode(seriesId, season) { value in
            print(value.name)
            //print(value.episodes)
            self.episodeInfo[season] = value
            completionHandler()
        }
    }
    

}


extension MainViewController: CollectionViewAttributeProtocol {
    func configureSearchBar() {
        mainSearchBar.delegate = self
    }
    
    func configureCollectionView() {
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        
        mainCollectionView.register(
            UINib(nibName: SeasonCollectionReusableView.identifier, bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SeasonCollectionReusableView.identifier
        )
        mainCollectionView.register(
            UINib(nibName: EpisodeCollectionViewCell.identifier, bundle: nil ),
            forCellWithReuseIdentifier: EpisodeCollectionViewCell.identifier
        )
    }
    
    func configureCollectionViewLayout() {
        
        let spacing: CGFloat = 10
        let width = UIScreen.main.bounds.width
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: width, height: 100)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: width, height: 50)
        
        mainCollectionView.collectionViewLayout = layout
    }
    
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let seasonInfo else { return 0 }
        
        // 첫 번재 애의 시즌넘버가 0이면, 하나씩 밀어서 뒤에꺼부터 하자
        // 그렇게 하지 말고, 시즌 매개변수를 넣어주면 스페셜도 나오지 않을까?
        
        return seasonInfo.seasons.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return episodeInfo[section].episodes.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeCollectionViewCell.identifier, for: indexPath) as? EpisodeCollectionViewCell else { return UICollectionViewCell() }
        
        cell.designCell(episodeInfo[indexPath.section].episodes[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if (kind == UICollectionView.elementKindSectionHeader) {
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SeasonCollectionReusableView.identifier, for: indexPath) as?
                    SeasonCollectionReusableView else { return UICollectionReusableView() }
            
            view.designCell((seasonInfo?.seasons[indexPath.section])!)
            
            return view
        }
        return UICollectionReusableView()
    }
    
    
}


extension MainViewController: UISearchBarDelegate {
    
}
