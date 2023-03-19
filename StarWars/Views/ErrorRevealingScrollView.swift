//
//  ErrorRevealingScrollView.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import UIKit

class ErrorRevealingScrollView: UIScrollView {
    let container = UIView()
    let errorContainer = UIView()

    let errorLabel = {
        let label = UILabel()

        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 23, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0

        return label
    }()

    let recoverySuggestionLabel = {
        let label = UILabel()

        label.textColor = .tertiaryLabel
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0

        return label
    }()

    let recoveryButton = {
        let button = UIButton()

        button.isHidden = true
        button.backgroundColor = .systemGray3
        button.layer.cornerRadius = 6
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)

        return button
    }()

    private lazy var errorInfoStackView = {
        let stackView = UIStackView(arrangedSubviews: [errorLabel, recoverySuggestionLabel, recoveryButton])

        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.setCustomSpacing(14, after: recoverySuggestionLabel)

        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContainer()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func didReceiveError(error: Error) {
        container.removeFromSuperview()
        setupErrorContainer()

        let (userFriendlyDescription, recoverySuggestion) = extractUserFriendlyErrorInfo(from: error)
        errorLabel.text = userFriendlyDescription
        recoverySuggestionLabel.text = recoverySuggestion
    }

    func didReceiveError(error: Error, recoveryButtonTitle: String, recoverySuggestionHandler: Selector, handlerTarget: Any) {
        didReceiveError(error: error)
        recoveryButton.isHidden = false
        recoveryButton.setTitle(recoveryButtonTitle, for: .normal)
        recoveryButton.addTarget(handlerTarget, action: recoverySuggestionHandler, for: .touchUpInside)
    }

    func restoreFromError() {
        errorContainer.removeFromSuperview()
        setupContainer()

        recoveryButton.isHidden = true
        errorLabel.text = nil
        recoverySuggestionLabel.text = nil
        recoveryButton.setTitle(nil, for: .normal)
    }

    func extractUserFriendlyErrorInfo(from error: Error)
        -> (userFriendlyDescription: String, recoverySuggestion: String) {
        if let error = error as? UserFriendlyError {
            return (error.userFriendlyDescription, error.userFriendlyRecoverySuggestion)
        }

        return (String.errors.somethingWentWrong, String.errors.tryAgainLater)
    }

    func setupContainer() {
        addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false

        let topPadding: CGFloat = 30
        let bottomPadding: CGFloat = 80
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor, constant: topPadding),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -bottomPadding),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.heightAnchor.constraint(greaterThanOrEqualTo: heightAnchor),
            container.widthAnchor.constraint(greaterThanOrEqualTo: widthAnchor),
        ])
    }

    func setupErrorContainer() {
        addSubview(errorContainer)
        errorContainer.translatesAutoresizingMaskIntoConstraints = false
        errorContainer.backgroundColor = .systemBackground

        NSLayoutConstraint.activate([
            errorContainer.topAnchor.constraint(equalTo: topAnchor),
            errorContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            errorContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            errorContainer.widthAnchor.constraint(equalTo: widthAnchor),
            errorContainer.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor),
        ])

        if errorInfoStackView.superview == nil {
            setupErrorInfoStackView()
        }
    }

    func setupErrorInfoStackView() {
        errorContainer.addSubview(errorInfoStackView)
        errorInfoStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            errorInfoStackView.centerYAnchor.constraint(equalTo: errorContainer.centerYAnchor),
            errorInfoStackView.centerXAnchor.constraint(equalTo: errorContainer.centerXAnchor),
            errorInfoStackView.widthAnchor.constraint(equalTo: errorContainer.widthAnchor, multiplier: 0.95),
        ])
    }
}
