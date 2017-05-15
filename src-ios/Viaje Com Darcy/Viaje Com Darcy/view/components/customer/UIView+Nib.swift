//
//  UIView+Nib.swift
//  PocBancoOriginal
//
//  Created by André Pinto on 21/01/16.
//  Copyright © 2016 Accenture. All rights reserved.
//

import UIKit

protocol UIViewLoading {}
extension UIView : UIViewLoading {}

extension UIViewLoading where Self : UIView {
    
    // note that this method returns an instance of type `Self`, rather than UIView
    static func loadFromNib() -> Self {
        let nibName = "\(self)".characters.split{$0 == "."}.map(String.init).last!
        let nib = UINib(nibName: nibName, bundle: nil)
        let owner = nib.instantiate(withOwner: self, options: nil).first as! Self
        return owner
    }
    
}
