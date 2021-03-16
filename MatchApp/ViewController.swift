//
//  ViewController.swift
//  MatchApp
//
//  Created by Ł.B Morapel on 09/03/2021.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collecionView: UICollectionView!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var timer: Timer?
    var miliseconds: Int = 10 * 1000
    
    let model = CardModel()
    var cardsArray = [Card]()
    
    var SoundPlayer = SoundManeger()
    
    var firstFlippedCardIndex: IndexPath?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.//
        cardsArray = model.getCards()
        
        // Set ViewController as the detasource and delegate of the collection view.
        collecionView.dataSource = self 
        collecionView.delegate = self
        
        // Set timer and Initialize
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerFired)  , userInfo: nil , repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
        
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
            // Play shuffle sound
        SoundPlayer.playSound(effect: .shuffle)
    }
    //MARK: - Timer Methods
    
    @objc func timerFired(){
        
        // Decrement the counter
        miliseconds -= 1
        
        //Update the label
        let seconds:Double = Double(miliseconds)/1000.0
        timerLabel.text = String(format: "Pozostały czas: %.2f", seconds)
        
        //Stop the timer if it reach zero
        
        if miliseconds == 0 {
            
            timerLabel.textColor = UIColor.red
            timer?.invalidate()
            
            // Check if the user has cleared all the pairs
            checkForGameEnd()
        }
        
       
    }
    
    // MARK: - Required Protocol UIVollecionViewDataSource methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // Return number of cards
        return cardsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Get a cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // configure the state of the cell based on the properties of the card that it represents
        //Get the card from the card array
        let customCell = cell as? CardCollectionViewCell
        
        let card = cardsArray[indexPath.row]
        
        // Configure the cell
        customCell?.configureCell(card: card)
        
        // Return it
    }
    //MARK: Protocol UIColletionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
    
        // Check if there is any time remaning if the time is 0
        
        if miliseconds <= 0{
            return
        }
        //Get a reference to the cell that was tapped
        let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
        
        // Chceck the status of the card deteriine how to flip it
        if cell?.card?.isFlipped == false && cell?.card?.isMatched == false {
            
            cell?.flipUp()
            SoundPlayer.playSound(effect: .flip)
        
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
            
            SoundPlayer.playSound(effect: .match)
            
            // Set the status and remove them
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            // Was that the last pair?
            checkForGameEnd()
          
            
        } else{
            
            //It's not match
            
            SoundPlayer.playSound(effect: .nomatch)
            //Flip them back over
            
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            cardOneCell?.flipDown()
            cardTwoCell?.flipDown()
        }
        
        // Reset the firstFlippedCardIndex property
    firstFlippedCardIndex = nil
    }
    
    func checkForGameEnd() {
        
        // Chec if theres any card that is unmached
        
        // Asume the user has won, loop all the cards to see if all of them are matched
        var hasWon = true
        
        for card in cardsArray {
            
            if card.isMatched == false {
            //We found a card that is unmatched
                hasWon = false
                break
            }
        }
        
        if hasWon == true {
            
            // User has won, show an alert
            showAlert(title: "Wygrana!", message: "Jesteś mistrzem!")
        }
        else{
            
            // User hasn't won yet, check if there's any time left
            if miliseconds <= 0  {
                showAlert(title: "Koniec Gry.", message: "Spróbuj jeszcze raz!")
            }
        }
        
    
    }
    
    func showAlert (title: String, message: String){
        
        // Create the alert
        let alert = UIAlertController (title: title, message: message, preferredStyle: .alert)
        
        // Add a buttopn for the user to dismiss it
        let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil )
   
        alert.addAction(okAction)
        
        // show the alert
        present(alert, animated: true, completion: nil)
    }
   
}

