//
//  UITextField+Ext.swift
//  Connector
//
//  Created by Abdelrhman Elmahdy on 02/10/2022.
//

import Combine
import UIKit

extension UITextField {
    var textPublisher: AnyPublisher<String?, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
            .map { ($0.object as? UITextField)?.text }
            .eraseToAnyPublisher()
    }

    func createBidirectionalBinding<Root>(with publisher: Published<String>.Publisher,
                                          keyPath: ReferenceWritableKeyPath<Root, String>,
                                          for object: Root,
                                          storeIn subscriptions: inout Set<AnyCancellable>) {
        // Make the keyPath property subscribe to the textField's text publisher.
        textPublisher
            .removeDuplicates()
            .sink(receiveValue: { object[keyPath: keyPath] = $0 ?? "" })
            .store(in: &subscriptions)

        // Make the textField's text property subscribe to the publisher's updates.
        publisher
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink(receiveValue: { self.text = $0 })
            .store(in: &subscriptions)
    }
}
