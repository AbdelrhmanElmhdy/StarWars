//
//  CardDetailsView.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 19/03/2023.
//

import UIKit

class CardDetailsView: UIView {
    let scrollView = UIScrollView()
    let imageView = UIImageView()
    let infoLabel = {
        let label = InsetLabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.contentInsets = .init(top: 0, left: 25, bottom: 0, right: 25)
        return label
    }()

    private(set) var cardViews: [CardsView] = []

    lazy var cardViewsStackView = {
        let stackView = UIStackView()

        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 40

        return stackView
    }()

    lazy var rootStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, infoLabel, cardViewsStackView])

        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 40

        return stackView
    }()

    init() {
        super.init(frame: .zero)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        setupScrollView()
        setupRootStackView()
        setupImageView()
        setupInfoLabel()
    }

    private func setupScrollView() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 140, right: 0)
        scrollView.fillSuperview()
    }

    private func setupRootStackView() {
        scrollView.addSubview(rootStackView)
        rootStackView.translatesAutoresizingMaskIntoConstraints = false
        rootStackView.fillSuperview()
    }

    private func setupImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.45),
        ])
    }

    private func setupInfoLabel() {
        infoLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
//            infoLabel.leadingAnchor.constraint(equalTo: rootStackView.leadingAnchor, constant: 20),
//            infoLabel.trailingAnchor.constraint(equalTo: rootStackView.leadingAnchor, constant: -20),
        ])
    }

    func appendCardsView(_ cardsView: CardsView) {
        cardViewsStackView.addArrangedSubview(cardsView)
        cardsView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        cardsView.heightAnchor.constraint(equalToConstant: 250).isActive = true
    }

    func appendCardViews(_ cardViews: [CardsView]) {
        for cardView in cardViews { appendCardsView(cardView) }
    }
}
