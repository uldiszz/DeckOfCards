//
//  CardsController.swift
//  DeckOfCards
//
//  Created by Uldis Zingis on 15/11/16.
//  Copyright © 2016 Uldis Zingis. All rights reserved.
//

import Foundation

class CardsController {

    static let sharedInstance = CardsController()
    var cards: [Card] = []
    var deckID: String?

    func loadNewDeck(completion: @escaping ((Bool, Error?) -> Void)) {
        guard let url = URL(string: "https://deckofcardsapi.com/api/deck/\(deckID ?? "new")/draw/?count=5") else { return }

        NetworkController.performRequest(for: url, httpMethod: .Get, urlParameters: nil, body: nil) { (data, error) in
            guard let data = data else { NSLog("No data returned."); completion(false, nil); return }

            if error != nil {
                NSLog("Error while loading new deck: \(error?.localizedDescription)")
                completion(false, error)
                return
            }

            guard let dict = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any] else { NSLog("Error serializing JSON data: \(error)"); completion(false, error); return }

            self.deckID = dict["deck_id"] as? String

            guard let cardsDict = dict["cards"] as? [[String: Any]] else { NSLog("Error mapping cards from JSON data: \(error)"); completion(false, error); return }

            for cardDict in cardsDict {
                guard let card = Card(dict: cardDict) else { NSLog("Error creating card from dict: \(error)"); completion(false, error); return }
                self.cards.append(card)
            }

            completion(true, nil)
        }
    }
}


