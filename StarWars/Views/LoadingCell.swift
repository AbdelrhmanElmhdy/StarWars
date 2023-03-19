//
//  LoadingCell.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 19/03/2023.
//

import Foundation
import UIKit
import SkeletonView

class LoadingCell: UICollectionViewCell {
    static let reuseIdentifier = "LoadingCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        isSkeletonable = true
        skeletonCornerRadius = 14
        contentView.isSkeletonable = true
        contentView.layer.cornerRadius = 14
        contentView.layer.cornerCurve = .continuous
        contentView.showAnimatedSkeleton(usingColor: .systemGray5)
        contentView.clipsToBounds = true
    }
}
