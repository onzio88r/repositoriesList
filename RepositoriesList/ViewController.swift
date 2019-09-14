//
//  ViewController.swift
//  RepositoriesList
//
//  Created by Daniele Rapali on 14/09/2019.
//  Copyright © 2019 Daniele Rapali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    var listRepositories = Repositories() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        
        getRepositoriesData()
        
    }
    
    
}

