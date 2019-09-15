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
        
        if indexPath.row == self.listRepositories.count - 2 && !isLoadingData {
            isLoadingData = true
            pageNumber += 1
            getRepositoriesData(page: pageNumber)
            
        }
        
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
        
        if Connectivity.isConnectedToInternet() {
        
            self.navigationController?.pushViewController(detailsVc, animated: true)
        
        }else {
            showAlert(message: "No Internet connection, you can see only the repositories list")
        }
        
    }
    
    
}

extension ViewController {
    
    
    /// Get repositories list from online
    func getRepositoriesData(page:Int) {
        ReposList(page: page, perPage: 10) { (response) in
            switch response {
                
            case .success( let result ):
                print("We have \(result.count) repositories")
                self.listRepositories.append(contentsOf: result)
                
            case .failure(let error):
                print("Erorr : ",error)
            }
        }
    }
    
    // Get repositories list from offline data
    func getRepositoriesDataOffline(){
        var repo:Repositories?
        if  let repoData = UserDefaults.standard.data(forKey: "RepositoryList") {
            repo = try! JSONDecoder().decode(Repositories.self, from: repoData)
            self.listRepositories = repo!
        }
        
        print("Repo from offline: ",repo?.count ?? 0)
    }
    
}
