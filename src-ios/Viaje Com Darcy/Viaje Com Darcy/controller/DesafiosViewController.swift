//
//  DesafiosViewController.swift
//  Viaje Com Darcy
//
//  Created by wildson.santos.silva on 11/04/17.
//  Copyright © 2017 Viaje Com Darcy. All rights reserved.
//

import UIKit
import SwiftCarousel

class DesafiosViewController: UIViewController, SWRevealViewControllerDelegate{

    @IBOutlet weak var btMenu: UIButton!
    @IBOutlet weak var carousel: SwiftCarousel!
    @IBOutlet weak var btAceitarDesafio: UIButton!
    
    var items: [String]?
    var itemsViews: [UILabel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMenu();
        
        
        
        self.revealViewController().delegate = self;
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer());
        
//        items = ["Elephants", "Tigers", "Chickens", "Owls", "Rats", "Parrots", "Snakes"]
//        itemsViews = items!.map { labelForString($0) }
//        carousel.items = itemsViews!
//        carousel.resizeType = .visibleItemsPerPage(3)
//        carousel.defaultSelectedIndex = 3
//        carousel.delegate = self
//        carousel.scrollType = .default
        
        
        
        
        
//        let carouselFrame = CGRect(x: view.center.x - 200.0, y: view.center.y - 100.0, width: 400.0, height: 200.0)
//        carouselView = SwiftCarousel(frame: carouselFrame)
        try! carousel.itemsFactory(itemsCount: 5) { choice in
            let imageView = UIImageView(image: UIImage(named: "puppy\(choice+1)"))
            imageView.frame = CGRect(origin: .zero, size: CGSize(width: 200.0, height: 200.0))
            
            return imageView
        }
        carousel.resizeType = .withoutResizing(10.0)
        carousel.delegate = self
        carousel.defaultSelectedIndex = 2
        view.addSubview(carousel)


        
       

        // Do any additional setup after loading the view.
    }
    
    func labelForString(_ string: String) -> UILabel {
        let text = UILabel()
        text.text = string
        text.textColor = .black
        text.textAlignment = .center
        text.font = .systemFont(ofSize: 24.0)
        text.numberOfLines = 0
        
        return text
    }
    
    @IBAction func selectTigers(_ sender: AnyObject) {
        carousel.selectItem(1, animated: true)
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

}

extension DesafiosViewController: SwiftCarouselDelegate {
    private func didSelectItem(item: UIView, index: Int) -> UIView? {
        
        btAceitarDesafio.setTitle("Aceitar \(index+1)", for: .normal)
        
        return nil
    }
    
    func willBeginDragging(withOffset offset: CGPoint) {
        btAceitarDesafio.setTitle("Aceitar", for: .normal)
    }
}


