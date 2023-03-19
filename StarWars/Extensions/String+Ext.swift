//
//  String+Ext.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Foundation
import UIKit

// MARK: + Utilities

extension String {
    var localized: String { NSLocalizedString(self, comment: "") }

    func attributedStringWithColor(_ subStrings: [String], color: UIColor, stringSize size: CGFloat = 16, coloredSubstringsSize: CGFloat = 16) -> NSAttributedString {
        let font: UIFont = .systemFont(ofSize: size)
        let attributedString = NSMutableAttributedString(string: self, attributes: [.font: font])

        for subString in subStrings {
            let range = (self as NSString).range(of: subString)
            let subStringFont: UIFont = .systemFont(ofSize: coloredSubstringsSize)
            attributedString.addAttributes([.foregroundColor: color, .font: subStringFont], range: range)
        }

        return attributedString
    }

    func attributedStringWithImage(_ image: UIImage?) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: "\(self) ")

        let imageAttachment = NSTextAttachment()
        imageAttachment.image = image

        let imageString = NSAttributedString(attachment: imageAttachment)

        attributedString.append(imageString)

        return attributedString
    }
}

// MARK: + Static Texts

extension String {
    // swiftlint:disable:next identifier_name
    static let ui = UITextsContainer.self
    static let errors = ErrorTextsContainer.self
    static let colors = ColorNamesContainer.self
    static let files = FileNamesContainer.self
    static let env = EnvironmentVariableNamesContainer.self
}

extension String {
    static func attributedStringFromDictionary(_ dict: [String: String], keyColor: UIColor, valueColor: UIColor) -> NSAttributedString {
        let attributedString = NSMutableAttributedString()

        for (index, (key, value)) in dict.enumerated() {
            let keyAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: keyColor]
            let valueAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: valueColor]

            let lineSeparator = index == dict.count - 1 ? "" : "\n\n"

            let keyAttributedString = NSAttributedString(string: "\(key): ", attributes: keyAttributes)
            let valueAttributedString = NSAttributedString(string: "\(value + lineSeparator)",
                                                           attributes: valueAttributes)

            attributedString.append(keyAttributedString)
            attributedString.append(valueAttributedString)
        }

        return attributedString
    }
}
