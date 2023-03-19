//
//  CardCell.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 18/03/2023.
//

import SkeletonView
import UIKit

class CardCell: UICollectionViewCell {
    static let reuseIdentifier = "StarWarsCardCell"

    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }

    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    let imageView = UIImageView()
    let titleLabel = {
        let label = UILabel()

        label.textColor = .white
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 3
        label.layer.shadowOpacity = 0.6
        label.layer.shadowOffset = CGSize(width: 0, height: 0)

        label.layer.masksToBounds = false
        label.numberOfLines = 3
        label.minimumScaleFactor = 0.7
        label.adjustsFontSizeToFitWidth = true

        return label
    }()

    private var titleLabelBottomAnchorConstraint: NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // Adapt title font size and padding dynamically based on cell frame size.
        let updatedFontSize = min(frame.width * 0.12, 34)
        let updatedBottomPadding = frame.height * 0.1

        titleLabel.font = .systemFont(ofSize: updatedFontSize, weight: .semibold)
        titleLabelBottomAnchorConstraint?.constant = -updatedBottomPadding
    }

    private func setup() {
        isSkeletonable = true
        skeletonCornerRadius = 14
        contentView.isSkeletonable = true
        contentView.layer.cornerRadius = 14
        contentView.layer.cornerCurve = .continuous
        contentView.clipsToBounds = true

        setupImageView()
        setupTitleLabel()
    }

    private func setupImageView() {
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.fillSuperview()
    }

    private func setupTitleLabel() {
        imageView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabelBottomAnchorConstraint =
            titleLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -15),
            titleLabelBottomAnchorConstraint!,
        ])
    }
}
