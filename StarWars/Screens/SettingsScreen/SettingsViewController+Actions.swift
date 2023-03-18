//
//  SettingsViewController+Actions.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import UIKit

extension SettingsViewController: SettingsViewControllerProtocol { // + Actions
    func didSelectUserInterfaceStyle(_ style: UIUserInterfaceStyle?) {
        viewModel.selectUserInterfaceStyle(style)
    }
}
