//
//  UIView+Ext.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import UIKit

extension UIView {
    func fillSuperview() {
        fillSuperviewWithInsets()
    }

    func fillSuperviewWithInsets(top: CGFloat = 0, leading: CGFloat = 0, bottom: CGFloat = 0, trailing: CGFloat = 0) {
        guard let superview = superview else {
            fatalError("Attempting to set constraints to a \(type(of: self)) before adding it to a superView")
        }

        fill(superview, top: top, leading: leading, bottom: bottom, trailing: trailing)
    }

    /// make `self` fill the specified `view` with specified margins.
    func fill(_ view: UIView, top: CGFloat = 0, leading: CGFloat = 0, bottom: CGFloat = 0, trailing: CGFloat = 0) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: top),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailing),
        ])
    }

    func tearDown() {
        for subview in subviews {
            subview.tearDown()
        }

        removeFromSuperview()
        NSLayoutConstraint.deactivate(constraints)
        removeConstraints(constraints)
    }
}
