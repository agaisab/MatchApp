//
//  CardModel.swift
//  MatchApp
//
//  Created by Ł.B Morapel on 09/03/2021.
//

import Foundation

class CardModel {
    
    func getCards() -> [Card] {
        
        // Declare an empty arra
        
        var generatedCards = [Card]()
        
        // Randomly generete 8 pair of cards
        
        for _ in 1...8{
            
            //Generate a random number
            let randomNumber = Int.random(in: 1...13)
            
            //Create two new card objects
            
            let cardOne = Card()
            let cardTwo = Card()
            
            //Set ther image names
            cardOne.imageName = "card\(randomNumber)"
            cardTwo.imageName = "card\(randomNumber)"
            
            //Add them to the array
            generatedCards.append(cardOne)
            generatedCards.append(cardTwo)
            print(randomNumber)
        }
        
        // Randomize the cards within the array
        
        generatedCards.shuffle()
        
        
        // Return the array
        
        return generatedCards
    }
}
