//
//  ViewController.swift
//  MatchApp
//
//  Created by Ł.B Morapel on 09/03/2021.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collecionView: UICollectionView!
    
    let model = CardModel()
    var cardsArray = [Card]()
    
    var firstFlippedCardIndex: IndexPath?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.//
        cardsArray = model.getCards()
        print(cardsArray)
        
        // Set ViewController as the detasource and delegate of the collection view.
        collecionView.dataSource = self 
        collecionView.delegate = self
    }
    
    
    // MARK: - Required Protocol UIVollecionViewDataSource methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // Return number of cards
        return cardsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Get a cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        print(cell)
        //Get the card from the card array
        let card = cardsArray[indexPath.row]
        
        // Configure the cell
        cell.configureCell(card: card)
        
        // Return it
        return cell
    }
    
    //MARK: Protocol UIColletionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        //Get a reference to the cell that was tapped
        let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
        
        // Chceck the status of the card deteriine how to flip it
       if cell?.card?.isFlipped == false {
            
            cell?.flipUp()
        
        // Check if this is the first card that was flipped or the second card
        if firstFlippedCardIndex == nil {
            //This is the first car flipped over
            //TODO: Reset firstFilled Card Index
            firstFlippedCardIndex = indexPath
            
        }else{
            // Second card is flipped
            // Run the comparison logic
            
            checkForMatch(indexPath)
            
        }
       }
    }
    //MARK: - Game Logic Methods
    
    func checkForMatch(_ secondFlippedCardIndex:IndexPath) {
        
        // Get the two card objects for the two indicies and see if the match
        let cardOne = cardsArray[firstFlippedCardIndex!.row]
        let cardTwo = cardsArray[secondFlippedCardIndex.row]
        
        // Get the two collecion view cells that represents CardOne and CardTwo
        
        let cardOneCell = collecionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        let cardTwoCell = collecionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        if cardOne.imageName == cardTwo.imageName {
            
           // It's a match
            
            // Set the status and remove them
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            cardOneCell?.remove()
            cardTwoCell?.remove()
          
            
        } else{
            
            //It's not match
            //Flip them back over
            
            cardOneCell?.flipDown()
            cardTwoCell?.flipDown()
        }
        
        // Reset the firstFlippedCardIndex property
    firstFlippedCardIndex = nil
    }
   
}

