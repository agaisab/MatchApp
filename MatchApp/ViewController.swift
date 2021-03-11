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
       }
       else{
        
        cell?.flipDown()
       }
    
    }
}

