//
//  ViewController.swift
//  Swoosh
//
//  Created by badal shah on 22/12/17.
//  Copyright © 2017 badal shah. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func movetoNextVc(_ sender: Any) {
      performSegue(withIdentifier: "showleague", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showleague" {
            guard let leaguevc = segue.destination as? LeagueVC
                else {return}
        }
    }
    
}

