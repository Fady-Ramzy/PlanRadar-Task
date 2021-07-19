//
//  CityTableViewCell.swift
//  PlanRadar-Task
//
//  Created by Fady Ramzy on 18/07/2021.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Methods
    
    func configure(with title: String?) {
        titleLabel.text = title
    }
}
