//
//  CardModel.swift
//  MatchApp
//
//  Created by Ł.B Morapel on 09/03/2021.
//

import Foundation

class CardModel {
    
    func getCards() -> [Card] {
        
        // Declare an empty array of CardsObjects
        var cardsArray = [Card]()
        // Declare array to store numbers that we generated
        var numofPairs = [Int]()
     
        // Randomly generete 8 pair of cards without doubles
        repeat {
            
            //Generate a random number
            let randomNumber = Int.random(in: 1...13)
    
            //Unique number statment
            if numofPairs.contains(randomNumber) == false {
                
                //Create two objects
                let cardOne = Card()
                let cardTwo = Card()
            
                //Set ther image names
                cardOne.imageName = "card\(randomNumber)"
                cardTwo.imageName = "card\(randomNumber)"
            
                //Add them to the array
                cardsArray.append(cardOne)
                cardsArray.append(cardTwo)
                
                //Add this number to numofPairs
                numofPairs.append(randomNumber)
                
            }
            
        } while (numofPairs.count<8)
        
        // Randomize the cards within the array
        cardsArray.shuffle()
        
        // Return the array
        return cardsArray
    }

}
