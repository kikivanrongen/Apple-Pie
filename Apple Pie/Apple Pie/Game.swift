//
//  Game.swift
//  Apple Pie
//
//  Created by Kiki van Rongen on 19-04-18.
//  Copyright © 2018 Kiki van Rongen. All rights reserved.
//

import Foundation

// create struct for current game status
struct Game {
    var word: String // word to be guessed
    var incorrectMovesRemaining: Int // number of moves left
    var guessedLetters: [Character] // list of guessed letters
    
    // check if chosen character is in word
    mutating func playerGuessed(letter: Character) {
        guessedLetters.append(letter) // append character to list of guessed letters
        if !word.characters.contains(letter) {
            incorrectMovesRemaining -= 1 // update number of remaining moves
        }
    }
    
    var formattedWord: String {
        var guessedWord = ""
        for letter in word.characters {
            if guessedLetters.contains(letter) {
                guessedWord += "\(letter)" // show guessed letters
            } else {
                guessedWord += "_" // hide missing letters
            }
        }
        
        return guessedWord
    }
}
