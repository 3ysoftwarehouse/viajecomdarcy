//
//  RoundedBorderedButton.swift
//  Viaje Com Darcy
//
//  Created by Vitor Albuquerque on 7/5/16.
//  Copyright © 2016 Vitor Albuquerque. All rights reserved.
//

import UIKit

class RoundedBorderedButton: RoundedButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor(red: 102.0/255.0, green: 115.0/255.0, blue: 128.0/255.0, alpha: 1.0).CGColor
        self.clipsToBounds = true
    }
    
    override func cornerRadius() -> CGFloat {
        return 20
    }

}
