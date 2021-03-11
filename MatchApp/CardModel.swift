//
//  CardModel.swift
//  MatchApp
//
//  Created by Ł.B Morapel on 09/03/2021.
//

import Foundation

class CardModel {
    
    
    var randomNumberTable = [Int]()
    
    
    func getCards() -> [Card] {
        
        // Declare an empty array of CardsObjects
        var generatedCards = [Card]()
     
        // Randomly generete 8 pair of cards without doubles 
        repeat {
            
            //Generate a random number
            let randomNumber = Int.random(in: 1...13)
            
            //Unique number statment
            if randomNumberTable.contains(randomNumber) == false {
                
                //Create two objects
                let cardOne = Card()
                let cardTwo = Card()
            
                //Set ther image names
                cardOne.imageName = "card\(randomNumber)"
                cardTwo.imageName = "card\(randomNumber)"
            
                //Add them to the array
                generatedCards.append(cardOne)
                generatedCards.append(cardTwo)
                randomNumberTable.append(randomNumber)
                print(randomNumber)
            }
            
        } while (randomNumberTable.count<8)
        
        // Randomize the cards within the array
        generatedCards.shuffle()
        
        
        // Return the array
        return generatedCards
    }
}
