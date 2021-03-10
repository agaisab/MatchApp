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
        
        // Set ViewController as the detasource and delegate of the collection view.
        
        collecionView.dataSource = self
        collecionView.delegate = self
    }

    
    
    // MARK: - Collecion View Methoths
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // Return number of cards
        return cardsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a cell
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath)
        
        // TODO: Finish configue the cell
        
        // Return it
        return cell
    }
}

