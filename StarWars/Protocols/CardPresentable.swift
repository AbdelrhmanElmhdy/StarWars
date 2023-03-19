//
//  CardPresentable.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 18/03/2023.
//

import Foundation
import UIKit

struct CardsReference: Codable {
    let referenceTitle: String
    let ids: [Int]
}

protocol CardPresentable: Codable {
    static var title: String { get }
    var title: String { get }
    var image: UIImage? { get }
    var referencedCards: [CardsReference] { get }
    var info: [String: String] { get }
}
