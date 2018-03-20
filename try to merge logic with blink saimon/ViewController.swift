//
//  ViewController.swift
//  try to merge logic with blink saimon
//
//  Created by Ishay on 3/20/18.
//  Copyright © 2018 Ishay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //1. all of the saimon playing buttons
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    //2. the score lives related varibals
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var livesLabel: UILabel!
    
    var scoreNumber : Int = 0
    var numberOfLives = 3
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

