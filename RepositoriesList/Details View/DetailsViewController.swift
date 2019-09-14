//
//  DetailsUIViewController.swift
//  RepositoriesList
//
//  Created by Daniele Rapali on 14/09/2019.
//  Copyright © 2019 Daniele Rapali. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var nameLabel: UILabel!
    var descriptionLabel: UILabel!
    var loginOwnerLabel: UILabel!
    var contributorsLabel: UILabel!
    
    var contributorsList = UITableView()
    
    var repoViewModel: CollectionViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contributorsList.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        contributorsList.delegate = self
        contributorsList.dataSource = self
        
        contributorsList.allowsSelection = false

        nameLabel = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: self.view.bounds.width, height: 15)))
        self.view.addSubview(nameLabel)
        
        descriptionLabel = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: self.view.bounds.width, height: 45)))
        descriptionLabel.numberOfLines = 3
        self.view.addSubview(descriptionLabel)
        
        loginOwnerLabel = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: self.view.bounds.width, height: 15)))
        self.view.addSubview(loginOwnerLabel)
        
        contributorsLabel = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: self.view.bounds.width, height: 15)))
        self.view.addSubview(contributorsLabel)
        
        self.view.addSubview(contributorsList)

        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        loginOwnerLabel.translatesAutoresizingMaskIntoConstraints = false
        contributorsLabel.translatesAutoresizingMaskIntoConstraints = false
        contributorsList.translatesAutoresizingMaskIntoConstraints = false
        
         let margin = view.layoutMarginsGuide
        
        self.nameLabel.topAnchor.constraint(equalTo: margin.topAnchor, constant: 25).isActive = true
        self.nameLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor, constant: 5).isActive = true
        self.nameLabel.trailingAnchor.constraint(equalTo: margin.trailingAnchor, constant: 5).isActive = true
        
        NSLayoutConstraint(item: descriptionLabel!, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1.0, constant: 5).isActive = true
        self.descriptionLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor, constant: 2).isActive = true
        self.descriptionLabel.trailingAnchor.constraint(equalTo: margin.trailingAnchor, constant: 2).isActive = true
        
        NSLayoutConstraint(item: loginOwnerLabel!, attribute: .top, relatedBy: .equal, toItem: descriptionLabel, attribute: .bottom, multiplier: 1.0, constant: 5).isActive = true
        self.loginOwnerLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor, constant: 2).isActive = true
        self.loginOwnerLabel.trailingAnchor.constraint(equalTo: margin.trailingAnchor, constant: 2).isActive = true
        
        NSLayoutConstraint(item: contributorsLabel!, attribute: .top, relatedBy: .equal, toItem: loginOwnerLabel, attribute: .bottom, multiplier: 1.0, constant: 5).isActive = true
        self.contributorsLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor, constant: 2).isActive = true
        self.contributorsLabel.trailingAnchor.constraint(equalTo: margin.trailingAnchor, constant: 2).isActive = true
        

        contributorsList.topAnchor.constraint(equalTo: contributorsLabel.bottomAnchor).isActive = true
        contributorsList.leftAnchor.constraint(equalTo: margin.leftAnchor).isActive = true
        contributorsList.bottomAnchor.constraint(equalTo: margin.bottomAnchor).isActive = true
        contributorsList.rightAnchor.constraint(equalTo: margin.rightAnchor).isActive = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureView(repoViewModel: repoViewModel)
    }

}
