//
//  UITableView+Ext.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import UIKit

extension UICollectionView {
    func setNoInternetConnectionMessage(_ message: String = .errors.noInternetConnection,
                                        tryAgainButtonTapHandler: Selector,
                                        tabHandlerTarget: Any) {
        setEmptyMessage(message, buttonTitle: .ui.tryAgain,
                        buttonTapHandler: tryAgainButtonTapHandler,
                        tabHandlerTarget: tabHandlerTarget)
    }

    func setEmptyMessage(_ message: String,
                         buttonTitle: String? = nil,
                         buttonTapHandler: Selector? = nil,
                         tabHandlerTarget: Any? = nil) {
        let backgroundView = UIView()
        setupBackgroundView(backgroundView)

        let messageLabel = UILabel()
        setupMessageLabel(backgroundView: backgroundView, label: messageLabel, message: message)

        if let buttonTitle = buttonTitle, let buttonTapHandler = buttonTapHandler, let tabHandlerTarget = tabHandlerTarget {
            let button = UIButton()
            button.addTarget(tabHandlerTarget, action: buttonTapHandler, for: .touchUpInside)
            setupButton(backgroundView: backgroundView, label: messageLabel, button: button, title: buttonTitle)
        }
    }

    func setupBackgroundView(_ view: UIView) {
        backgroundView = view
        view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.widthAnchor.constraint(equalTo: widthAnchor),
            view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.6),
        ])
    }

    func setupMessageLabel(backgroundView: UIView, label: UILabel, message: String) {
        backgroundView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = message
        label.textColor = .systemGray2
        label.font = .systemFont(ofSize: 23, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0

        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor, constant: 60),
            label.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            label.widthAnchor.constraint(lessThanOrEqualTo: backgroundView.widthAnchor),
        ])
    }

    func setupButton(backgroundView: UIView, label: UILabel, button: UIButton, title: String) {
        backgroundView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.backgroundColor = .systemGray3
        button.layer.cornerRadius = 6
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)

        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            button.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            button.widthAnchor.constraint(lessThanOrEqualTo: backgroundView.widthAnchor),
        ])
    }

    func restore() {
        backgroundView = nil
    }
}
