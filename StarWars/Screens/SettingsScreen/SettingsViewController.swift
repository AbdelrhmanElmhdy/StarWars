//
//  SettingsViewController.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import UIKit

class SettingsViewController: UITableViewController {
    // MARK: Properties

    static let settingsCellReuseIdentifier = "settingsCellReuseIdentifier"

    unowned var coordinator: DisclosingSettings

    let viewModel: SettingsViewModel
    var datasource: SettingsDataSource?

    // MARK: Initialization

    init(coordinator: DisclosingSettings, viewModel: SettingsViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(style: .insetGrouped)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGroupedBackground

        tableView.dataSource = datasource
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Self.settingsCellReuseIdentifier)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar()
        tableView.reloadData()
    }

    // MARK: TableView Delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let settingsOption = datasource?.getSettingsOption(forIndexPath: indexPath)

        switch settingsOption {
        case let .disclosure(option):
            option.tapHandler?()
            coordinator.disclose(option)
        case let .button(option):
            option.tapHandler()
        case let .value(option):
            option.tapHandler(option.value)
            datasource?.updateSelectedValue(option.value, forTableView: tableView)
        case .switch, .none:
            break
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: Convenience

    private func configureNavBar() {
        let isRootSettingsViewController = !(navigationController?.previousViewController is SettingsViewController)

        if isRootSettingsViewController {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode = .always
        } else {
            navigationItem.largeTitleDisplayMode = .never
        }
    }
}

// MARK: Preview

#if canImport(SwiftUI) && DEBUG
    import SwiftUI

    @available(iOS 13.0, *)
    struct SettingsTableViewController_Preview: PreviewProvider { // swiftlint:disable:this type_name
        static var previews: some View {
            ForEach(DEVICE_NAMES, id: \.self) { deviceName in
                UIViewControllerPreview {
                    AppDelegate.shared.viewControllersFactory.makeSettingsViewController(for: SettingsStackCoordinatorMock())
                }.previewDevice(PreviewDevice(rawValue: deviceName))
                    .previewDisplayName(deviceName)
            }
        }
    }
#endif
