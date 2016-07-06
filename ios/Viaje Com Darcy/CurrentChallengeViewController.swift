//
//  CurrentChallengeViewController.swift
//  Viaje Com Darcy
//
//  Created by Vitor Albuquerque on 7/5/16.
//  Copyright © 2016 Vitor Albuquerque. All rights reserved.
//

import UIKit

class CurrentChallengeViewController: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    
    var challenge: Challenge?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        loadChallengeIntoView()
    }
    
    func loadChallengeIntoView() {
        titleLbl.text = challenge?.title
        descriptionLbl.text = challenge?.description
    }
    
    @IBAction func onAcceptChallengeClick(sender: AnyObject) {
        
    }
    
    
}
