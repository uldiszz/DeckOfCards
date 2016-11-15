//
//  CollectionViewController.swift
//  DeckOfCards
//
//  Created by Uldis Zingis on 15/11/16.
//  Copyright © 2016 Uldis Zingis. All rights reserved.
//

import UIKit

private let reuseIdentifier = "card"

class CollectionViewController: UICollectionViewController {

    @IBAction func reloadButtonTapped(_ sender: Any) {
        CardsController.sharedInstance.loadNewDeck { (isSuccess, error) in
            if error != nil {
                NSLog("Error loading new deck: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        CardsController.sharedInstance.loadNewDeck { (isSuccess, error) in
            if error != nil {
                NSLog("Error loading new deck: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CardsController.sharedInstance.cards.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)

        let card = CardsController.sharedInstance.cards[indexPath.row]
        ImagesController.image(forURL: card.imageURL) { (image) in
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: 0, y: 0, width: 80, height: 100)
            
            cell.contentView.addSubview(imageView)
        }

        return cell
    }
}
