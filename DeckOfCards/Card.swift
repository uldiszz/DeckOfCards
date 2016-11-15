//
//  Card.swift
//  DeckOfCards
//
//  Created by Uldis Zingis on 15/11/16.
//  Copyright © 2016 Uldis Zingis. All rights reserved.
//

import Foundation

class Card {
    let kImage = "image"
    let kValue = "value"
    let kSuit = "suit"
    let kCode = "code"

    let imageURL: String
    let value: String
    let suit: String
    let code: String

    init(imageURL: String, value: String, suit: String, code: String) {
        self.imageURL = imageURL
        self.value = value
        self.suit = suit
        self.code = code
    }

    init?(dict: [String: Any]) {
        guard let image = dict[kImage] as? String, let value = dict[kValue] as? String, let suit = dict[kSuit] as? String, let code = dict[kCode] as? String else { return nil }
        self.imageURL = image
        self.code = code
        self.suit = suit
        self.value = value
    }
}
