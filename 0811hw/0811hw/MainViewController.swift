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
    
    
    @IBOutlet var mainTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        let nib = UINib(nibName: "MovieTableViewCell", bundle: nil)
        mainTableView.register(nib, forCellReuseIdentifier: "MovieTableViewCell")
        
        mainTableView.rowHeight = 430

        callRequest(callRequest2)
    }
    
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
                        print(index, self.movieList[index].genreString)
                    }
                }
            }
            
            self.mainTableView.reloadData()
        }
        
        
//        let url = "https://api.themoviedb.org/3/genre/movie/list"
//
//        let header: HTTPHeaders = ["Authorization" : APIKey.tmdb]
//
//
//        // SwiftyJSON : Work with Alamofire
//        AF.request(url, method: .get, headers: header)
//            .validate()
//            .responseJSON { response in
//                switch response.result {
//                case .success(let value):
//                    let json = JSON(value)
//                    print("JSON22: \(json)")
//
//
//                    // 3중 loop...?
//                    for (index, movie) in self.movieList.enumerated() {
//                        print(index, movie.genre)
//                        self.movieList[index].genreString.removeAll()
//
//                        for movieGenre in movie.genre {
//
//                            for g in json["genres"].arrayValue {
//
//                                if g["id"].intValue == movieGenre {
//                                    self.movieList[index].genreString.append(g["name"].stringValue)
//                                }
//                                print(index, self.movieList[index].genreString)
//                            }
//                        }
//                    }
//
//                    self.mainTableView.reloadData()
//
//
//
//
//                case .failure(let error):
//                    print(error)
//                }
//            }

    }
    
    
    
    // 일단 여기서 호출해보고, 다른 파일에 옮겨서 completion handler 사용하자
    func callRequest(_  completion: @escaping () -> Void) {
        
        APIManager.shared.callRequest(.movieTrend, 0) { json in
            for item in json["results"].arrayValue {
                print(item)
                
                let date = item["release_date"].stringValue
                // let genre = item["genre_ids"].arrayValue // 일단 스트링으로
                var genre: [Int] = []
                for g in item["genre_ids"].arrayValue {
                    genre.append(g.intValue)
                }
                
                let mainImage = item["poster_path"].stringValue
                let backImage = item["backdrop_path"].stringValue   // 일단 이건 어떻게 하는건지 모르겠음 지금
                let rate = item["vote_average"].doubleValue
                let title = item["title"].stringValue
                
                let id = item["id"].intValue
                let overView = item["overview"].stringValue
                
                let newMovie = MovieForMain(id: id, date: date, genre: genre, genreString: [], mainImage: mainImage, backImage: backImage, rate: rate, title: title, overview: overView)
                
                self.movieList.append(newMovie)
            }
            
            completion()
            //print(self.movieList)
            self.mainTableView.reloadData()
        }
        
        
        
        
        
//        // 최종 url
//        let url = "https://api.themoviedb.org/3/trending/movie/week?language=en-US"
//
//        // header (HTTPHeader 아님!!)
//        let header: HTTPHeaders = ["Authorization" : APIKey.tmdb]
//
//        // SwiftyJSON : Work with Alamofire
//        AF.request(url, method: .get, headers: header)
//            .validate()
//            .responseJSON { response in
//                switch response.result {
//                case .success(let value):
//                    let json = JSON(value)
//                    //print("JSON: \(json)")
//
//                    for item in json["results"].arrayValue {
//                        print(item)
//
//                        let date = item["release_date"].stringValue
//                        // let genre = item["genre_ids"].arrayValue // 일단 스트링으로
//                        var genre: [Int] = []
//                        for g in item["genre_ids"].arrayValue {
//                            genre.append(g.intValue)
//                        }
//
//                        let mainImage = item["poster_path"].stringValue
//                        let backImage = item["backdrop_path"].stringValue   // 일단 이건 어떻게 하는건지 모르겠음 지금
//                        let rate = item["vote_average"].doubleValue
//                        let title = item["title"].stringValue
//
//                        let id = item["id"].intValue
//                        let overView = item["overview"].stringValue
//
//                        let newMovie = MovieForMain(id: id, date: date, genre: genre, genreString: [], mainImage: mainImage, backImage: backImage, rate: rate, title: title, overview: overView)
//
//                        self.movieList.append(newMovie)
//                    }
//
//                    completion()
//                    //print(self.movieList)
//                    self.mainTableView.reloadData()
//
//
//
//                case .failure(let error):
//                    print(error)
//                }
//        }
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
