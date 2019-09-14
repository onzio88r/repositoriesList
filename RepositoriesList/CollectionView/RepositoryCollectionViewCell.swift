//
//  RepositoryCollectionViewCell.swift
//  RepositoriesList
//
//  Created by Daniele Rapali on 14/09/2019.
//  Copyright © 2019 Daniele Rapali. All rights reserved.
//

import UIKit

class RepositoryCollectionViewCell: UICollectionViewCell {
    
    fileprivate var nameLabel: UILabel!
    fileprivate var descriptionLabel: UILabel!
    fileprivate var loginOwnerLabel: UILabel!
    fileprivate var contributors: UILabel!
        
    var repository: Repository! {
        didSet {
            
            self.nameLabel.text = "Name: \(repository.name)"
            self.descriptionLabel.text = "Description: \(repository.repositoryDescription ?? "")"
            self.loginOwnerLabel.text = "Owner: \(repository.owner.login)"
            self.contributors.text = "Contributors: "
            
            self.backgroundColor = repository.fork ? .green : .white
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        
        self.nameLabel = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: frame.width-10, height: 15)))
        self.addSubview(nameLabel)
        
        self.descriptionLabel = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: frame.width, height: 15)))
        self.addSubview(descriptionLabel)
        
        self.loginOwnerLabel = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: frame.width, height: 15)))
        self.addSubview(loginOwnerLabel)
        
        self.contributors = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: frame.width, height: 15)))
        self.addSubview(contributors)
        
        
        cellConstraint()
        
    }
    
    private func cellConstraint(){
        //MARK: - Constraint
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        loginOwnerLabel.translatesAutoresizingMaskIntoConstraints = false
        contributors.translatesAutoresizingMaskIntoConstraints = false
        
        self.nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2).isActive = true
        self.nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2).isActive = true
        self.nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 2).isActive = true
        
        NSLayoutConstraint(item: descriptionLabel!, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1.0, constant: 2).isActive = true
        self.descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2).isActive = true
        self.descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 2).isActive = true
        
        NSLayoutConstraint(item: loginOwnerLabel!, attribute: .top, relatedBy: .equal, toItem: descriptionLabel, attribute: .bottom, multiplier: 1.0, constant: 2).isActive = true
        self.loginOwnerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2).isActive = true
        self.loginOwnerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 2).isActive = true
        
        NSLayoutConstraint(item: contributors!, attribute: .top, relatedBy: .equal, toItem: loginOwnerLabel, attribute: .bottom, multiplier: 1.0, constant: 2).isActive = true
        self.contributors.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2).isActive = true
        self.contributors.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 2).isActive = true
        
        
    }
}
