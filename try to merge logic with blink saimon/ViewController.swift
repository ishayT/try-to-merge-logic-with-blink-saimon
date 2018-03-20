//
//  ViewController.swift
//  try to merge logic with blink saimon
//
//  Created by Ishay on 3/20/18.
//  Copyright © 2018 Ishay. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    //MARK:- 1. all of the saimon playing buttons
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    
    //MARK:- 2. the score lives related varibals
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var livesLabel: UILabel!
    var scoreNumber : Int = 0
    var numberOfLives = 3
    var numberOfRounds : Int = 0 // might need to delete this it's unnessesery
    
    
    //MARK:- 3. varibles related for playing the sounds and glow in the game
    var gameTimer: Timer!
    var soundPlayer : AVAudioPlayer!
    var selectedSound : String = ""
    let arrayOfSounds = ["buttonSound1", "buttonSound2", "buttonSound3", "buttonSound4"]
    
    //MARK:- 4. other varibles related to logic in the game
    var randomNumber : Int = 0
    var computerFinishedPlaying = false
    var counterForTheComputerTurn : Int = 0
    
    var arrayOfBtnNumbersPlayedByTheComp: [Int] = [Int]()
    var arrayOfBtnNumbersPlayedByThePlayer: [Int] = [Int]()
    var arrayOfButtons : [UIButton] = []
    
    
    //MARK:- 5. ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrayOfButtons = [button1, button2, button3, button4]
        
        //disable buttons
        changeThePlayButtons(isEnabledStatus: false, arrayOfButtons: arrayOfButtons)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    func changeThePlayButtons(isEnabledStatus: Bool, arrayOfButtons: [UIButton]){
        for i in 0...arrayOfButtons.count - 1 {
            arrayOfButtons[i].isEnabled = isEnabledStatus
        }
    }
    
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        startButton.isEnabled = false
        loadNewGame()
    }
    
    func loadNewGame() {
        print("start over started")
        
        arrayOfBtnNumbersPlayedByTheComp.removeAll()
        scoreNumber = 0
        numberOfRounds = 0
        numberOfLives = 3
        updateUI()
        //startNewRound()
    }
    
    func updateUI(){
        scoreLabel.text = "score = \(scoreNumber)"
        livesLabel.text = "Lives = \(numberOfLives)"
    }

}

