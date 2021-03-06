//
//  CardCollectionViewCell.swift
//  MatchApp
//
//  Created by Ł.B Morapel on 09/03/2021.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!
    
    var card:Card?
    
    func configureCell(card:Card) {
        
        // Keep track of the card
        self.card = card
        
        //Set the front image view to the image that represent the card
        frontImageView.image = UIImage(named: card.imageName)
        
        if card.isMatched == true{
            backImageView.alpha = 0
            frontImageView.alpha = 0
            return
        } else{
            backImageView.alpha = 1
            frontImageView.alpha = 1 
        }
        
        //reset the state of the cell, by checking flip status of the card and the showing the front or back.
        if card.isFlipped == true {
            //Show the front image view
            flipUp(speed: 0)
        
        }
        else{
            flipDown(speed: 0, delay: 0)
            
        }
    }
    
    func flipUp(speed:TimeInterval = 0.3){
        
        // Flip up animation
        UIView.transition(from: backImageView, to: frontImageView, duration: speed, options: [.showHideTransitionViews,.transitionFlipFromLeft], completion: nil)
        
        // set the status of the card
        card?.isFlipped = true
    }
    
    func flipDown(speed:TimeInterval = 0.3, delay: TimeInterval = 0.5) {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            
            UIView.transition(from: self.frontImageView, to: self.backImageView, duration: speed, options: [.showHideTransitionViews,.transitionFlipFromLeft], completion: nil)
        }
        
        
        // Set the status of the card
        card?.isFlipped = false
        
    }
    func remove() {
        
        //Make the image views inivible
        backImageView.alpha = 0
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            
            self.frontImageView.alpha = 0
            
        }, completion:  nil)
    }

}


