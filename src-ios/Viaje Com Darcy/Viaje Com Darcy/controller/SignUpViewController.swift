//
//  SignUpViewController.swift
//  Viaje Com Darcy
//
//  Created by wildson.santos.silva on 13/02/17.
//  Copyright © 2017 Viaje Com Darcy. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

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

}
