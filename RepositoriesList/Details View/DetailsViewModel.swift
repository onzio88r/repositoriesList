//
//  DetailsViewModel.swift
//  RepositoriesList
//
//  Created by Daniele Rapali on 14/09/2019.
//  Copyright © 2019 Daniele Rapali. All rights reserved.
//

import Foundation
import UIKit

extension DetailsViewController {
    func configureView(repoViewModel: CollectionViewModel){
        self.nameLabel.text = repoViewModel.name
        self.descriptionLabel.text = repoViewModel.description
        self.loginOwnerLabel.text = repoViewModel.loginOwner
        self.contributorsLabel.text = "Contributors: \(repoViewModel.contributors?.count ?? 0)"
        
    }

}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoViewModel.contributors?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle,
                                   reuseIdentifier: "cell")
        
        let contributor = repoViewModel.contributors![indexPath.row]
        
        cell.textLabel?.text = contributor.login
        cell.detailTextLabel?.text = "contribution: \(contributor.contributions)"
        
        return cell
    }
    
    
}
