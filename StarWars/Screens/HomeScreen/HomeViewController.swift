//
//  HomeViewController.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import UIKit

class HomeViewController: UITableViewController {
    // MARK: Properties

    private unowned let coordinator: Coordinator
    private let viewModel: HomeViewModel

    let dataSource = HomeTableViewDataSource()

    private lazy var dataBinder = HomeViewControllerAndViewModelBinder(viewController: self, viewModel: viewModel)

    // MARK: Initialization

    init(coordinator: Coordinator, viewModel: HomeViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchCharacters()
    }
}

// MARK: Preview

#if canImport(SwiftUI) && DEBUG
    import SwiftUI

    @available(iOS 13.0, *)
    struct HomeViewController_Preview: PreviewProvider { // swiftlint:disable:this type_name
        static var previews: some View {
            ForEach(DEVICE_NAMES, id: \.self) { deviceName in
                UIViewControllerPreview {
                    AppDelegate.shared.viewControllersFactory.makeHomeViewController(for: HomeStackCoordinatorMock())
                }.previewDevice(PreviewDevice(rawValue: deviceName))
                    .previewDisplayName(deviceName)
            }
        }
    }
#endif
