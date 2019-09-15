//
//  ViewController.swift
//  RepositoriesList
//
//  Created by Daniele Rapali on 14/09/2019.
//  Copyright © 2019 Daniele Rapali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    /// Collection view for repositories list
    fileprivate let collectionView:UICollectionView = {
       
        let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            cv.register(RepositoryCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        return cv
    }()
    
    
    /// List of repositories, decoded from Json
    var listRepositories = Repositories() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationController?.navigationBar.topItem?.title = "Repositories"

        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let margin = view.layoutMarginsGuide
        
        collectionView.backgroundColor = .lightGray
        collectionView.trailingAnchor.constraint(equalTo: margin.trailingAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: margin.leadingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalToSystemSpacingBelow: margin.topAnchor, multiplier: 1.0).isActive = true
        collectionView.bottomAnchor.constraint(equalToSystemSpacingBelow: margin.bottomAnchor, multiplier: 1.0).isActive = true
        
        if Connectivity.isConnectedToInternet() {
            print("Yes! internet is available.")
            getRepositoriesData()
        }else {
            print("Internet not available, we'll try to use the offline data")
            getRepositoriesDataOffline()
        }
        
        
        
    }
    
}

extension UIViewController {
    
    /// ActionSheet popup to show messages.
    ///
    /// - Parameter message: Text to show on the dialog popup
    func showAlert(message:String){
        
        let optionMenu = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "OK", style: .cancel)
        
        optionMenu.addAction(deleteAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
}

