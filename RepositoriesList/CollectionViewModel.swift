//
//  collectionViewModel.swift
//  RepositoriesList
//
//  Created by Daniele Rapali on 14/09/2019.
//  Copyright © 2019 Daniele Rapali. All rights reserved.
//

import Foundation

class CollectionViewModel {
    
    var name: String
    var description: String
    var loginOwner: String
    var contributors: Int
    
    init(repository: Repository){
        self.name = "Name: \(repository.name)"
        self.description = "Description: \(repository.repositoryDescription ?? "")"
        self.loginOwner = "Owner: \(repository.owner.login)"
        self.contributors = 0
    }
    
}
