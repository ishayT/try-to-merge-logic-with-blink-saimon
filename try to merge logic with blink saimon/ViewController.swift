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

    //MARK:- 6.changeThePlayButtons(isEnabledStatus) makes the 4 game buttons enable/disable
    func changeThePlayButtons(isEnabledStatus: Bool, arrayOfButtons: [UIButton]){
        for i in 0...arrayOfButtons.count - 1 {
            arrayOfButtons[i].isEnabled = isEnabledStatus
        }
    }
    
    //MARK:- 7.start button pressed
    @IBAction func startButtonPressed(_ sender: UIButton) {
        startButton.isEnabled = false
        loadNewGame()
    }
    
    
    func loadNewGame() {
        
        arrayOfBtnNumbersPlayedByTheComp.removeAll()
        scoreNumber = 0
        numberOfRounds = 0
        numberOfLives = 3
        
        randomNumber = Int(arc4random_uniform(4)+1)
        arrayOfBtnNumbersPlayedByTheComp.append(self.randomNumber)
        updateUI()
        startNewRound()
    }
    
    //MARK:- 8.update UI ------> need to check if i should add a text for round number and good bad ansowers on the start button
    func updateUI(){
        scoreLabel.text = "score = \(scoreNumber)"
        livesLabel.text = "Lives = \(numberOfLives)"
    }

    //MARK:- 9.start a new round of buttons played by the computer
    func startNewRound() {
        changeThePlayButtons(isEnabledStatus: false, arrayOfButtons: arrayOfButtons)
        
        arrayOfBtnNumbersPlayedByThePlayer.removeAll()
        gameTimer = Timer.scheduledTimer(timeInterval: 1.3, target: self, selector: #selector(usingButtonsArray), userInfo: nil, repeats: true)
    }
    
    @objc func usingButtonsArray() {
        makeComputerButtonFlash(buttons: arrayOfButtons)
    }
    
    //MARK:- 10.The function that calls for the sound and animation for each button played by the computer i needed to call         this function with another @objc function(usingButtonsArray) cos the selector of the Timer couldent get varibles such as [UIButton] when calling the makeComputerButtonFlash directly
    func makeComputerButtonFlash(buttons: [UIButton]) {
        selectedSound = arrayOfSounds[arrayOfBtnNumbersPlayedByTheComp[counterForTheComputerTurn] - 1]
        
        if counterForTheComputerTurn == arrayOfBtnNumbersPlayedByTheComp.count - 1{
            
            buttons[arrayOfBtnNumbersPlayedByTheComp[counterForTheComputerTurn] - 1].flash()
            playSound()
            gameTimer.invalidate()
            counterForTheComputerTurn = 0
            changeThePlayButtons(isEnabledStatus: true, arrayOfButtons: arrayOfButtons)
            //TODO: make a label to notifiy the player it's his turn
            return
        }
        
        if counterForTheComputerTurn < arrayOfBtnNumbersPlayedByTheComp.count - 1 {
            buttons[arrayOfBtnNumbersPlayedByTheComp[counterForTheComputerTurn] - 1].flash()
            playSound()
            counterForTheComputerTurn += 1
            print([counterForTheComputerTurn - 1])
        }
    }
    
    
    @IBAction func gameButtonsPressedByTheUser(_ sender: UIButton) {
        selectedSound = arrayOfSounds[sender.tag - 1]
        arrayOfBtnNumbersPlayedByThePlayer.append(sender.tag)
        
        // adding glow and sound for the buttons
        for i in 1...4 {
            if i == sender.tag {
                sender.flash()
                playSound()
            }
        }
        
        for index in 0...arrayOfBtnNumbersPlayedByThePlayer.count-1{
            
            if arrayOfBtnNumbersPlayedByThePlayer[index] == arrayOfBtnNumbersPlayedByTheComp[index] {
                print("you are right")
                scoreNumber = scoreNumber + 5 + 2 * numberOfRounds
                updateUI()
                print(scoreNumber)
            } else {
                print("you are wrong")
                numberOfLives -= 1
                scoreNumber = scoreNumber - 5
                updateUI()
                print(scoreNumber)
                if numberOfLives == 0 {
                    //gameOver()
                }
                break
            }
        }
        
        if arrayOfBtnNumbersPlayedByThePlayer.count == arrayOfBtnNumbersPlayedByTheComp.count {
            randomNumber = Int(arc4random_uniform(4)+1)
            arrayOfBtnNumbersPlayedByTheComp.append(self.randomNumber)
            startNewRound()
        }
    }
    
    
    
    //MARK:- 15.playSound method - play the selected sound from the sound array
    func playSound(){
        let soundURL = Bundle.main.url(forResource: selectedSound, withExtension: "wav")
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: soundURL!)
        } catch {
            print(error)
        }
        soundPlayer.play()
    }
}


extension UIButton {
    
    func flash(){
        let flash = CABasicAnimation(keyPath: "shadowOpacity")
        flash.duration = 0.7
        flash.fromValue = 1
        flash.toValue = 0
        flash.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        flash.autoreverses = false
        flash.repeatCount = 1
        
        layer.shadowColor = UIColor.white.cgColor
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize(width: 0, height: 0)
        
        layer.add(flash, forKey: nil)
    }
}

