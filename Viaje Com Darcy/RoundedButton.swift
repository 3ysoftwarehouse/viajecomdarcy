//
//  RoundedButton.swift
//  Viaje Com Darcy
//
//  Created by Vitor Albuquerque on 6/27/16.
//  Copyright © 2016 Vitor Albuquerque. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.height / 2
    }
    
}
