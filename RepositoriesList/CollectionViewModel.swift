//
//  collectionViewModel.swift
//  RepositoriesList
//
//  Created by Daniele Rapali on 14/09/2019.
//  Copyright © 2019 Daniele Rapali. All rights reserved.
//

import Foundation

public class CollectionViewModel {
    
    public let name: String
    public let  description: String
    public let  loginOwner: String
    public var  contributors: Int
    public let  fork: Bool
    public let  contributorsUrl: String
    
    
    init(repository: Repository){
        self.name = "Name: \(repository.name)"
        self.description = "Description: \(repository.repositoryDescription ?? "")"
        self.loginOwner = "Owner: \(repository.owner.login)"
        self.contributors = 0
        self.fork = repository.fork
        self.contributorsUrl = repository.contributorsURL
    }

    
}
