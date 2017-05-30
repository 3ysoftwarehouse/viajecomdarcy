//
//  CardView.swift
//  Viaje Com Darcy
//
//  Created by wildson.santos.silva on 24/05/17.
//  Copyright © 2017 Viaje Com Darcy. All rights reserved.
//

import UIKit

class CardView: UIView {

    @IBOutlet weak var imgCardUiView: UIImageView!
    
    func setImagem(i:Int){
    
        var urlImg = "";
        
        if(i == 0){
            urlImg = "img1.jpg";
        }else if(i==1){
            urlImg = "img2.jpg";
        }else if(i==2){
            urlImg = "img3.png";
        }
        
        
        self.imgCardUiView.image = UIImage(named: urlImg)
    }

}
