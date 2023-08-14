//
//  MainViewController.swift
//  0811hw
//
//  Created by 임승섭 on 2023/08/11.
//

import UIKit
import SwiftyJSON
import Alamofire

class MainViewController: UIViewController {
    
    var movieList: [MovieForMain] = []
    
    var movies: TrendMovies?
    var genres: GenreMoives?
    
    
    @IBOutlet var mainTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        let nib = UINib(nibName: "MovieTableViewCell", bundle: nil)
        mainTableView.register(nib, forCellReuseIdentifier: "MovieTableViewCell")
        
        mainTableView.rowHeight = 400

        // callRequest가 끝나고 callRequest2가 실행되도록 @escaping 사용
        callRequest(callRequest2)
    }
    
    // 장르 api 호출
    func callRequest2() {
        
        APIManager.shared.callRequest(.movieGenre, 0) { json in
            // 3중 loop...?
            for (index, movie) in self.movieList.enumerated() {
                print(index, movie.genre)
                self.movieList[index].genreString.removeAll()
                
                for movieGenre in movie.genre {
                    
                    for g in json["genres"].arrayValue {
                        
                        if g["id"].intValue == movieGenre {
                            self.movieList[index].genreString.append(g["name"].stringValue)
                        }
                        //print(index, self.movieList[index].genreString)
                    }
                }
            }
            
            self.mainTableView.reloadData()
        }
    }
    
    // 영화 api 호출
    func callRequest(_  completion: @escaping () -> Void) {
        
        APIManager.shared.callRequest(.movieTrend, 0) { json in
            for item in json["results"].arrayValue {
                //print(item)
                
                let date = item["release_date"].stringValue
                
                var genre: [Int] = []
                for g in item["genre_ids"].arrayValue {
                    genre.append(g.intValue)
                }
                
                let mainImage = item["poster_path"].stringValue
                let backImage = item["backdrop_path"].stringValue
                let rate = item["vote_average"].doubleValue
                let title = item["title"].stringValue
                
                let id = item["id"].intValue
                let overView = item["overview"].stringValue
                
                let newMovie = MovieForMain(id: id, date: date, genre: genre, genreString: [], mainImage: mainImage, backImage: backImage, rate: rate, title: title, overview: overView)
                
                self.movieList.append(newMovie)
            }
            
            // 영화에 대한 정보를 받아왔으면, 이제 장르코드에 맞춰서 장르 문자열 배열로 저장
            completion()
            
            self.mainTableView.reloadData()
        }
    }
    

}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as! MovieTableViewCell
        
        
        cell.designCell(movieList[indexPath.row])
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        vc.movieID = movieList[indexPath.row].id
        vc.movieName = movieList[indexPath.row].title
        vc.overView = movieList[indexPath.row].overview
        
        vc.mainImageLink = movieList[indexPath.row].mainImage
        vc.backImageLink = movieList[indexPath.row].backImage
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
