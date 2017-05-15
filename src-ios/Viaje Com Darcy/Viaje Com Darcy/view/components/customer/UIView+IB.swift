//
//  ACView.swift
//  PocBancoOriginal
//
//  Created by André Pinto on 21/01/16.
//  Copyright © 2016 Accenture. All rights reserved.
//

import UIKit

/* Extension do add these fields to Interface Builder:
- cornerRadius
- borderWidth
- borderColor
*/
extension UIView {
    
    // MARK: Shape
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    @IBInspectable var cornerRadiusBottomRight: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            
            let maskPath:UIBezierPath = UIBezierPath(roundedRect: self.bounds,
                                                     byRoundingCorners: [UIRectCorner.topLeft , UIRectCorner.topRight , UIRectCorner.bottomLeft], cornerRadii: CGSize.init(width: 10.0, height: 0.0))
            
            let maskLayer:CAShapeLayer = CAShapeLayer()
            maskLayer.frame = self.bounds;
            maskLayer.path  = maskPath.cgPath;
            layer.mask = maskLayer;

        }
    }
    
    
    // MARK: Border
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
}

/** UIView subclass with added shadow fields displayed in Interface Builder (besides the border ones):
 - shadowColor
 - shadowOffset
 - shadowOpacity
 - shadowRadius
*/
//@IBDesignable
class IBView: UIView {
    
    var shadowLayer: CAShapeLayer!
    var shadowNeedsUpdate: Bool = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if (shadowNeedsUpdate) {
            shadowNeedsUpdate = false
            
            // remove previous
            shadowLayer?.removeFromSuperlayer()

            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.fillColor = layer.backgroundColor
            
            shadowLayer.shadowColor = shadowColor?.cgColor
            shadowLayer.shadowOffset = shadowOffset
            shadowLayer.shadowOpacity = shadowOpacity
            shadowLayer.shadowRadius = shadowRadius
            
            layer.insertSublayer(shadowLayer, at: 0)
//            layer.insertSublayer(shadowLayer, below: nil) // also works
            layer.masksToBounds = false
        }
    }
    
    override var cornerRadius: CGFloat {
        didSet {
//            shadowNeedsUpdate = true
        }
    }

    @IBInspectable var shadowColor: UIColor? {
        didSet {
            shadowNeedsUpdate = true
        }
    }
    
    @IBInspectable var shadowOffset: CGSize =  CGSize.zero {
        didSet {
            shadowNeedsUpdate = true
        }
    }

    @IBInspectable var shadowOpacity: Float = 0 {
        didSet {
            shadowNeedsUpdate = true
        }
    }

    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
            shadowNeedsUpdate = true
        }
    }
}

/* Simple subclasses to use in Interface Builder
*/
//@IBDesignable
class IBButton: UIButton {}
//@IBDesignable
class IBLabel: UILabel {}
//@IBDesignable
class IBSegmentedControl: UISegmentedControl {}

