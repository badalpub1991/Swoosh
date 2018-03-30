//
//  LeagueVC.swift
//  Swoosh
//
//  Created by badal shah on 22/12/17.
//  Copyright © 2017 badal shah. All rights reserved.
//

import UIKit

class LeagueVC: UIViewController {
    var player: Player?
    @IBOutlet weak var btnNext: BASCustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       player = Player()
        // Do any additional setup after loading the view.
    }

    @IBAction func onBtnMensClick(_ sender: Any) {
       SelectLeague(selectleague: "Men")
    }
    
    @IBAction func onBtnWomensClick(_ sender: Any) {
SelectLeague(selectleague: "Women")
        
    }
    
    @IBAction func onBtnCoedClick(_ sender: Any) {
        SelectLeague(selectleague: "COED")
    }

    @IBAction func onBtnNextClick(_ sender: Any) {
        performSegue(withIdentifier: "showskill", sender: self)
    }
    
    func SelectLeague(selectleague : String){
        player?.desiredLeague = selectleague
        btnNext.isEnabled=true
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let skillVC = segue.destination as? SkillVC  {
            skillVC.player=player
        }
    }
    
}

