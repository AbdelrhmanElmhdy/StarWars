//
//  UISearchBar+Ext.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 19/03/2023.
//

import Foundation
import UIKit
import Combine

extension UISearchBar {
    var textPublisher: AnyPublisher<String?, Never> {
        searchTextField.textPublisher
    }
}
