//
//  HomeView.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 18/03/2023.
//

import Foundation
import UIKit

class HomeView: UIView {
    let scrollView = ErrorRevealingScrollView(frame: .zero)
    let cardViews: [CardsView]

    lazy var cardViewsStackView = {
        let stackView = UIStackView(arrangedSubviews: cardViews)

        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 40

        return stackView
    }()

    init(cardViews: [CardsView]) {
        self.cardViews = cardViews
        super.init(frame: .zero)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        setupScrollView()
        setupCardViewsStackView()
        setupCardViews()
    }

    private func setupScrollView() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.fillSuperview()
    }

    private func setupCardViewsStackView() {
        scrollView.container.addSubview(cardViewsStackView)
        cardViewsStackView.translatesAutoresizingMaskIntoConstraints = false
        cardViewsStackView.fillSuperview()
    }

    private func setupCardViews() {
        for cardsView in cardViews {
            cardsView.widthAnchor.constraint(equalTo: scrollView.container.widthAnchor).isActive = true
            cardsView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        }
    }
}
