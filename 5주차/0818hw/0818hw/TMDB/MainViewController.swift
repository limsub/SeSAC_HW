//
//  MainViewController.swift
//  0818hw
//
//  Created by 임승섭 on 2023/08/18.
//

import UIKit

// 8/18



// 1. series_id -> TV 시리즈 정보 [season]
// 2. series_id, season_number -> TV 시리즈 및 시즌 별 정보 [episode]
// 3. query -> TV 시리즈 어아다 series_id


// 시간 오래 걸린 부분
// 1. 에피소드들의 정보를 저장하는 부분.
    // 맨 처음엔 시즌이 몇 개인지 알 수 없기 때문에, 배열의 초기 크기를 지정할 수 없다
    // for문을 돌면서 append를 하면 비동기 네트워크 통신의 끝나는 지점이 다르기 때문에 시즌 순서가 꼬인다
    // 시즌 정보를 받은 후, episode 배열에 append로 빈 구조체를 넣어서 나중에 인덱스로 접근할 수 있게 하였다

// 2. 시즌 0가 있는 시리즈와 없는 시리즈
    // numberOfSeasons 값에는 시즌 0가 포함되지 않는다
    // 에피소드 배열의 0번째 인덱스에 접근하려고 하면 에러가 발생한다 (indexOutOfRange)

// 3. QuickType 구조체 옵셔널
    // 특정 response를 기반으로 quicktype에서 구조체를 만들기 때문에, 다른 response에는 일치하지 않을 수도 있다
    // null값을 갖는 key는 옵셔널 타입으로 수정해주었다.
    // 프로젝트에서 사용하지 않는 key는 지웠다.


class MainViewController: UIViewController {
    
    @IBOutlet var mainSearchBar: UISearchBar!
    @IBOutlet var mainCollectionView: UICollectionView!
    
    // 현재 화면에 있는 TV Series 정보
    var seasonInfo: Tv?
    
    // 현재 화면에 있는 TV Series Season별 정보
    var episodeInfo: [Tvdetail] = []
    
    // TV Series ID
    var seriesId = 113268
    
    // 시즌 0 (스페셜) 의 유무 -> 배열의 인덱스 접근 시 필요 (indexOutOfRange)
    var isSeason0 = false
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkSeason0()
        
        mainCollectionView.keyboardDismissMode = .onDrag
        
        configureSearchBar()
        configureCollectionView()
        configureCollectionViewLayout()
    }
    
    func checkSeason0() {
        if (seasonInfo?.numberOfSeasons != seasonInfo?.seasons.count) {
            isSeason0 = true
        } else {
            isSeason0 = false
        }
    }
    
    // 시리즈의 시즌 정보를 받는다
    func callSeasonRequest(_ seriesId: Int) {
        TmdbAPIManager.shared.callSeason(seriesId) { value in
            self.seasonInfo = value
            
            
            //print(value.seasons)
            
            //print("====================================")
            
            
            print(self.seasonInfo?.numberOfSeasons) // 이걸로 가자     (x)
            print(self.seasonInfo?.seasons.count)   // 이걸로 간다 (x)     (o)
            // 1. numberOfSeasons : 스페셜 시즌은 포함하지 않는다
            // 2. seasons.count : 스페셜 시즌을 포함한 모든 시즌 배열의 카운트
            
            self.checkSeason0()
            
            // 스페셜 시즌도 화면에 보여주기 위해 2를 선택했다
            guard let seasonCnt = self.seasonInfo?.seasons.count else { return }
            //print("seasonCnt : \(seasonCnt)")
            
            
            
            // episodeInfo 배열
            // 기존 생각 : for 문을 돌면서, episodeInfo 배열에 맨 처음 시즌별로 append로 담아주려고 했다
            // 문제점 : 비동기 네트워크 통신을 하기 때문에 시즌 순서대로 응답이 오지 않아서, 시즌 정보가 꼬이게 된다
            // 임시방편 해결책 : 이전 통신에서 받은 시즌의 개수만큼 빈 구조체를 생성해서 배열에 저장한다. 즉, 배열의 크기를 지정한다
            //               배열에 append로 추가하는 방식이 아닌, 배열에 인덱스로 접근해서 각각의 구조체를 저장한다
            //               n개의 시즌이 있을 때, 배열의 크기는 n + 1이어야, 시즌의 number를 그대로 인덱스로 사용할 수 있다
            //               시즌0 (스페셜 시즌)의 여부에 따라 셀을 보여줄 때는 indexPath.section에 + 1을 해줄지 말지 결정한다
            
            // 빈 구조체를 배열에 추가해서, 배열의 크기를 지정한다
            for _ in 1...(seasonCnt + 1) {
                self.episodeInfo.append(Tvdetail(id: "", airDate: "", episodes: [], name: "", overview: "", tvdetailID: 0, posterPath: "", seasonNumber: 0, voteAverage: 0))
            }
            
            
            //print("====================================")
            
            // DispatchGroup() -> 해당 시리즈의 모든 시즌에 대한 응답이 도착했을 때, 화면 reload를 진행한다
            let group = DispatchGroup()
            guard let allSeasons = self.seasonInfo?.seasons else { return }
            
            for item in allSeasons {
                group.enter()
                // print(item.seasonNumber)
                self.callEpisodeRequest(seriesId, item.seasonNumber) {
                    group.leave()
                }
            }
           
            group.notify(queue: .main) {
                //print("end")
                self.mainCollectionView.reloadData()
            }
            
        }
    }
    
    
    // callSeasonRequest에서 series 정보를 받아온 후 실행된다
    // 각 시즌별 에피소드들의 정보를 받는다
    func callEpisodeRequest(_ seriesId: Int, _ season: Int, completionHandler: @escaping ()-> Void ) { // 여기서의 season은 인덱스라고 생각
        TmdbAPIManager.shared.callEpisode(seriesId, season) { value in
            //print(value.name)
            //print(value.episodes)
            //print("call Episode: seson - \(season)")
            
            // 기존에 (시즌 개수 + 1)만큼 배열의 크기를 지정해두었기 때문에, 인덱스로 접근할 수 있다.
            // 배열에 저장된 방식은 (인덱스 == 시즌 넘버) 이다
            // 시즌 0 (스페셜 시즌)이 없는 시리즈는 0번째 인덱스에 빈 구조체가 들어있기 때문에 접근하면 에러가 발생한다
            self.episodeInfo[season] = value
            completionHandler()     // DispatchGroup의 leave를 실행시키기 위한 completionHandler를 추가해주었다
        }
    }
    
    // searchBar에 시리즈 이름을 검색했을 때 실행된다
    // 일치하는 시리즈가 있을 때, id를 받아서 seriesId에 저장하고,
    // 다시 callSeason 함수를 실행한다
    func callSearchList(_ query: String) {
        TmdbAPIManager.shared.callSearch(query) { value in
//            print(value)
            
            // result가 비어있다 -> 일치하는 TV 시리즈가
            // result가 비어있으면 일치하는 TV 시리즈가 없다는 뜻이므로, 시리즈 정보 요청을 보내지 않는다
            if !value.results.isEmpty {
                self.seriesId = value.results[0].id
                self.callSeasonRequest(self.seriesId)
            }
        }
    }
}


// CollectionCell Configure (delegate, datasource 연결, nib 연결, cell layout 설정)
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

        return seasonInfo.seasons.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // 시즌 0 (스페셜 시즌)의 유무에 따라 배열 접근을 다르게 한다
        // 만약 시즌 0가 없는데, 0번째 인덱스 요소에 접근하려고 하면 에러가 발생할 가능성이 있다. (빈 구조체이기 때문)
        // 그리고 시즌 0가 없으면 첫 번째 섹션에 시즌 1의 정보가 나타나게 하려면 0번째 인덱스에 접근하면 안된다
        if (isSeason0) {
            return episodeInfo[section].episodes.count
        } else {
            return episodeInfo[section+1].episodes.count
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeCollectionViewCell.identifier, for: indexPath) as? EpisodeCollectionViewCell else { return UICollectionViewCell() }
        
        // 마찬가지로 시즌 0의 유무에 따라 인덱스 접근을 다르게 한다
        if (isSeason0) {
            cell.designCell(episodeInfo[indexPath.section].episodes[indexPath.row])
        }
        else {
            cell.designCell(episodeInfo[indexPath.section+1].episodes[indexPath.row])
        }
        
        
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
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }
        
        // 빈 문자열이 아닐 때, 검색을 진행한다
        // 일치하는 TV 시리즈가 있는지는 series 정보를 받고 난 후 판단한다
        if query != "" {
            callSearchList(query)
        }
    }
}
