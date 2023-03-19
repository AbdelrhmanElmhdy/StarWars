//
//  CardsViewHeader.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import UIKit

class CardsViewHeader: UIView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        return label
    }()

    let showAllButton = {
        let button = UIButton()

        let arrowForward = UIImage.arrowForward.withTintColor(.accent, renderingMode: .alwaysOriginal)
        let attributedAddBtnTitle = String.ui.showAll.attributedStringWithImage(arrowForward)
        button.setAttributedTitle(attributedAddBtnTitle, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.setTitleColor(.label, for: .normal)
        button.setTitleColor(button.titleColor(for: .normal)?.withAlphaComponent(0.3), for: .highlighted)

        return button
    }()

    private lazy var rootStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, showAllButton])

        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 4

        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupSubviews() {
        addSubview(rootStackView)
        rootStackView.translatesAutoresizingMaskIntoConstraints = false

        showAllButton.setContentHuggingPriority(.required, for: .horizontal)

        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: topAnchor),
            rootStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            rootStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
    }
}
