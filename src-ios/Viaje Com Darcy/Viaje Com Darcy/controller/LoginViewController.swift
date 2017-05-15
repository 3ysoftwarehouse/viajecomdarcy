//
//  LoginViewController.swift
//  Viaje Com Darcy
//
//  Created by wildson.santos.silva on 13/02/17.
//  Copyright © 2017 Viaje Com Darcy. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBack(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true);
    }
    @IBAction func onLogin(_ sender: UIButton) {
        
        
//        self.performSegue(withIdentifier: "goToDesafios", sender: self);
        
        let storyboard = UIStoryboard(name:"Desafios", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "SWReveal") as! SWRevealViewController
        self.present(vc, animated: false) { () -> Void in
            
        }

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
