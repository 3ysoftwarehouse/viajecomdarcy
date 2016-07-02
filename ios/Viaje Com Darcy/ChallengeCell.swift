//
//  DesafioCell.swift
//  Viaje Com Darcy
//
//  Created by Vitor Albuquerque on 7/2/16.
//  Copyright © 2016 Vitor Albuquerque. All rights reserved.
//

import UIKit

class ChallengeCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configureCell(challenge: Challenge) {
        titleLabel.text = challenge.title
        descriptionLabel.text = challenge.description
    }
    

}
