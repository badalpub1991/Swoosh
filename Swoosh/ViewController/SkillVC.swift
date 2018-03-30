//
//  SkillVC.swift
//  Swoosh
//
//  Created by badal shah on 22/12/17.
//  Copyright © 2017 badal shah. All rights reserved.
//

import UIKit

class SkillVC: UIViewController {
    var player: Player!
    @IBOutlet weak var lblSelectedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblSelectedLabel.text = player.desiredLeague

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func MovetoHomeView(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
