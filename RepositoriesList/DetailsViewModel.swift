//
//  DetailsViewModel.swift
//  RepositoriesList
//
//  Created by Daniele Rapali on 14/09/2019.
//  Copyright © 2019 Daniele Rapali. All rights reserved.
//

import Foundation
import UIKit

extension DetailsUIViewController {
    func configureView(repoViewModel: CollectionViewModel){
        self.nameLabel.text = repoViewModel.name
        self.descriptionLabel.text = repoViewModel.description
        self.loginOwnerLabel.text = repoViewModel.loginOwner
        self.contributors.text = "Contributors: \(repoViewModel.contributors)"
    }
}
