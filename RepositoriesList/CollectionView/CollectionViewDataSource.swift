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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RepositoryCollectionViewCell
        
        let repository = listRepositories[indexPath.row]
        
        let model = CollectionViewModel(repository: repository)
        
        ContributorsList(contributionUrl: repository.contributorsURL) { (response ) in
            switch response {
            case .success(let result) :
                print(result.count)
                model.contributors = result
                cell.repoViewModel = model
            case .failure(let error):
                print(error)
            }
        }
        
        cell.repoViewModel = model
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsVc = DetailsViewController()
        let cell = collectionView.cellForItem(at: indexPath) as! RepositoryCollectionViewCell
        detailsVc.repoViewModel = cell.repoViewModel
        cell.isSelected = true
        
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
                self.getRepositoriesDataOffline()
            }
        }
    }
    
    func getRepositoriesDataOffline(){
        var repo:Repositories?
        if  let repoData = UserDefaults.standard.data(forKey: "RepositoryList") {
            repo = try! JSONDecoder().decode(Repositories.self, from: repoData)
            self.listRepositories = repo!
        }
        
        print("Repo from offline: ",repo?.count ?? 0)
    }
    
}
