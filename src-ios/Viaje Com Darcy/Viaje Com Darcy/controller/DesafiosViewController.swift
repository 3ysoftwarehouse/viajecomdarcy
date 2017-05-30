//
//  DesafiosViewController.swift
//  Viaje Com Darcy
//
//  Created by wildson.santos.silva on 11/04/17.
//  Copyright © 2017 Viaje Com Darcy. All rights reserved.
//

import UIKit

class DesafiosViewController: UIViewController, SWRevealViewControllerDelegate, iCarouselDelegate, iCarouselDataSource{

    @IBOutlet weak var btMenu: UIButton!
    @IBOutlet weak var btAceitarDesafio: UIButton!
    
    var items:[Int] = [];
    
    @IBOutlet var carousel: iCarousel!;
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for i in 1 ... 3 {
            items.append(i)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carousel.type = .rotary
        
        setupMenu();
        
        self.revealViewController().delegate = self;
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer());
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setupMenu(){
        
        if self.revealViewController() != nil {
            btMenu.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: UIControlEvents.touchUpInside)
            
            self.revealViewController().rearViewRevealWidth = UIScreen.main.bounds.size.width - 50
            self.revealViewController().frontViewShadowColor = UIColor.clear
        }
    }
    func closeMenu(){
        self.revealViewController().revealToggle(animated: true);
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return items.count;
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        /*var label: UILabel
        var itemView: UIImageView
        
        //reuse view if available, otherwise create a new view
        if let view = view as? UIImageView {
            itemView = view
            //get a reference to the label in the recycled view
            label = itemView.viewWithTag(1) as! UILabel
        } else {
            //don't do anything specific to the index within
            //this `if ... else` statement because the view will be
            //recycled and used with other index values later
            itemView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
            itemView.image = UIImage(named: "puppy1.jpg")
            itemView.contentMode = .center
            
            label = UILabel(frame: itemView.bounds)
            label.backgroundColor = UIColor.clear
            label.textAlignment = .center
            label.font = label.font.withSize(50)
            label.tag = 1
            itemView.addSubview(label)
        }
        
        //set item label
        //remember to always set any properties of your carousel item
        //views outside of the `if (view == nil) {...}` check otherwise
        //you'll get weird issues with carousel item content appearing
        //in the wrong place in the carousel
        label.text = "\(items[index])"
        
        return itemView*/
        let view  = CardView.loadFromNib();
        view.setImagem(i: index)
        return view;
    }
    
    func carousel(carousel: iCarousel, valueForOption option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 1.1
        }
        return value
    }

}


