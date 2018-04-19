//
//  ViewController.swift
//  Apple Pie
//
//  Created by Kiki van Rongen on 18-04-18.
//  Copyright © 2018 Kiki van Rongen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound() // start new game
    }
    
    // create outlet for solution label
    @IBOutlet weak var correctWordLabel: UILabel!
    
    // create outlet for score label
    @IBOutlet weak var scoreLabel: UILabel!
    
    // create outleg for tree image
    @IBOutlet weak var treeImageView: UIImageView!
    
    // create outlet for all letter buttons
    @IBOutlet var letterButtons: [UIButton]!
    
    // function for pressed button
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    var listOfWords: [String] = ["food", "names", "hobbies", "animals", "household objects", "cats", "dogs", "gorgeous"] // possibile words to be guessed in the game
    let incorrectMovesAllowed = 7 // determine maximum number of incorrect moves
    
    var totalWins = 0 {
        didSet {
            newRound() // start new game if total wins changes
        }
    }
    
    var totalLosses = 0 {
        didSet {
            newRound() // start new game if total losses changes
        }
    }
    
    // create game
    var currentGame: Game!
    
    // function that enables a new game to start
    func newRound() {
        // check if word list is empty
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst() // remove first element from list of words
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: []) // determine new word and update remaining moves
            enableLetterButtons(true) // enable buttons
            updateUI() // update game
        } else {
            enableLetterButtons(false)
        }
    }
    
    // function that updates UI
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord.characters {
            letters.append(String(letter))
        }
        
        let wordWithSpacing = letters.joined(separator: " ") // insert space between underscores and letters
        
        // show tree image, guessed letters and total wins and losses in UI
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    // function that updates game status
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1 // increase losses if game is lost
        } else if currentGame.word == currentGame.formattedWord {
                totalWins += 1 // increase wins if word is guessed correctly
        } else {
            updateUI() // otherwise update UI
        }
    }
    
    // function that enables letter buttons when new game is started
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

