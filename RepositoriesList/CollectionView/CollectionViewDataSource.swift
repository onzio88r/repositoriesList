//
//  CollectionViewDataSource.swift
//  RepositoriesList
//
//  Created by Daniele Rapali on 14/09/2019.
//  Copyright © 2019 Daniele Rapali. All rights reserved.
//

import Foundation
import UIKit

extension ViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listRepositories.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RepositoryCollectionViewCell
        
        cell.repository = listRepositories[indexPath.row]
            
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsVc = DetailsUIViewController()
        self.navigationController?.pushViewController(detailsVc, animated: true)
    }
    
}

extension ViewController {
    
    func getRepositoriesData() {
        ReposList { (response) in
            switch response {
                
            case .success( let result ):
                print("We have \(result.count) repositories")
                self.listRepositories = result
                
            case .failure(let error):
                print("Erorr : ",error)
            }
        }
    }
    
}
