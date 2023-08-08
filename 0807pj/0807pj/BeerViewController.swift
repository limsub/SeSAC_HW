//
//  BeerViewController.swift
//  0807pj
//
//  Created by 임승섭 on 2023/08/08.
//

import UIKit
import Alamofire
import SwiftyJSON

class BeerViewController: UIViewController {
    
    @IBOutlet var beerCollectionView: UICollectionView!
    
    var beerList: [Beer] = [];

    override func viewDidLoad() {
        super.viewDidLoad()

        beerCollectionView.dataSource = self
        beerCollectionView.delegate = self
        
        let nib = UINib(nibName: "BeerCollectionViewCell", bundle: nil)
        beerCollectionView.register(nib, forCellWithReuseIdentifier: "BeerCollectionViewCell")
        
        callRequest()
        configureCollectionViewLayout()
    }
    
    func callRequest() {
        
        let url = "https://api.punkapi.com/v2/beers"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print("JSON: \(json)")
                
                for item in json.arrayValue {
                    
                    let url = URL(string: item["image_url"].stringValue)
                    
                    let name = item["name"].stringValue
                    let description = item["description"].stringValue
                    
                    print(name)
                    self.beerList.append(Beer(imageUrl: url, name: name, description: description))
                }
                
                
                self.beerCollectionView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}

extension BeerViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return beerList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BeerCollectionViewCell", for: indexPath) as! BeerCollectionViewCell

        cell.designCell(beerList[indexPath.row])
        
        return cell
    }
    
    
    func configureCollectionViewLayout() {
            let layout = UICollectionViewFlowLayout()
            let spacing: CGFloat = 10
            let width = UIScreen.main.bounds.width - (spacing * 3)
            
            layout.scrollDirection = .vertical
            layout.itemSize = CGSize(width: width/2, height: 300)
            layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
            
            layout.minimumLineSpacing = spacing
            layout.minimumInteritemSpacing = spacing
            beerCollectionView.collectionViewLayout = layout
        }
    
    
}
