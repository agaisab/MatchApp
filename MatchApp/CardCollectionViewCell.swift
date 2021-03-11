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
    }
    
    //Flip up animation
    
    func flipUp(){
        UIView.transition(from: backImageView, to: frontImageView, duration: 0.5, options: [.showHideTransitionViews,.transitionFlipFromLeft], completion: nil)
    }
    
    func flipDown() {
        
    }
}
