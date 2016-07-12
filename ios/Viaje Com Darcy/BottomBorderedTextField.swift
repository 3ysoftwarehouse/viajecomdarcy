//
//  BottomBorderedTextField.swift
//  Viaje Com Darcy
//
//  Created by Vitor Albuquerque on 7/11/16.
//  Copyright © 2016 Vitor Albuquerque. All rights reserved.
//

import UIKit

class BottomBorderedTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let border = CALayer()
        let borderWidth = CGFloat(1.0)
        
        let fieldHeight = self.frame.size.height
        let fieldWidth  = self.frame.size.width
        
        border.borderColor = UIColor.darkGrayColor().CGColor
        
        border.frame = CGRect(x: 0,
                              y: fieldHeight - borderWidth,
                              width:  fieldWidth,
                              height: fieldHeight)
        
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }

}
