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
        
        //reset the state of the cell, by checking flip status of the card and the showing the front or back.
        if card.isFlipped == true {
            //Show the front image view
            flipUp(speed: 0)
        
        }
        else{
            flipDown(speed: 0)
            
        }
    }
    
    func flipUp(speed:TimeInterval = 0.3){
        
        // Flip up animation
        UIView.transition(from: backImageView, to: frontImageView, duration: speed, options: [.showHideTransitionViews,.transitionFlipFromLeft], completion: nil)
        
        // set the status of the card
        card?.isFlipped = true
    }
    
    func flipDown(speed:TimeInterval = 0.3) {
        
        UIView.transition(from: frontImageView, to: backImageView, duration: speed, options: [.showHideTransitionViews,.transitionFlipFromLeft], completion: nil)
        
        // Set the status of the card
        card?.isFlipped = false
    }
}
