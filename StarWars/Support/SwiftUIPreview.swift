//
//  SwiftUIPreview.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Foundation

#if canImport(SwiftUI) && DEBUG
    import SwiftUI

    let DEVICE_NAMES: [String] = [ // swiftlint:disable:this identifier_name
        "iPhone 14 Pro Max",
        "iPhone SE (3rd generation)",
    ]

    struct UIViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
        let viewController: ViewController

        init(_ builder: @escaping () -> ViewController) {
            viewController = builder()
        }

        // MARK: - UIViewControllerRepresentable

        func makeUIViewController(context: Context) -> ViewController {
            viewController
        }

        func updateUIViewController(
            _ uiViewController: ViewController,
            context: UIViewControllerRepresentableContext<UIViewControllerPreview<ViewController>>
        ) {
        }
    }

    @available(iOS 13, *)
    public struct UIViewPreview<View: UIView>: UIViewRepresentable {
        public let view: View

        public init(_ builder: @escaping () -> View) {
            view = builder()
        }

        // MARK: - UIViewRepresentable

        public func makeUIView(context: Context) -> UIView {
            view
        }

        public func updateUIView(_ view: UIView, context: Context) {
            view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        }
    }
#endif
