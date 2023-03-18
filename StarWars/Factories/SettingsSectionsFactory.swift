//
//  SettingsSectionsFactory.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Foundation
import UIKit

struct SettingsSectionsFactory {
    let userPreferences: UserPreferences

    init(userPreferences: UserPreferences) {
        self.userPreferences = userPreferences
    }

    func createRootSettingsSections(forViewController targetVC: SettingsViewController) -> [SettingsSection] {
        let darkModeSettingsOptions = createDarkModeSettingsOptions(forViewController: targetVC)

        let darkModeSettingsOption = SettingsDisclosureOption(label: .ui.darkModeOption, children: darkModeSettingsOptions)

        let languageSettingsOption = SettingsDisclosureOption(label: .ui.languageOption, children: [])
        languageSettingsOption.defaultValue = Locale.current.languageCode == "en" ? "EN" : "ع"
        languageSettingsOption.tapHandler = {
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        }

        return [
            SettingsSection(options: [
                .disclosure(option: darkModeSettingsOption),
                .disclosure(option: languageSettingsOption),
            ]),
        ]
    }

    func createDarkModeSettingsOptions(forViewController targetVC: SettingsViewController) -> [SettingsSection] {
        let tapHandler: (_: Int) -> Void = { [weak targetVC] value in
            let selectedUserInterfaceStyle = UIUserInterfaceStyle(rawValue: value)
            targetVC?.didSelectUserInterfaceStyle(selectedUserInterfaceStyle)
            UserDefaults.standard.set("ar", forKey: "AppleLanguage")
        }

        let offValue = SettingsValueOption(label: .ui.off,
                                           value: UIUserInterfaceStyle.light.rawValue,
                                           tapHandler: tapHandler)

        let onValue = SettingsValueOption(label: .ui.on,
                                          value: UIUserInterfaceStyle.dark.rawValue,
                                          tapHandler: tapHandler)

        let systemValue = SettingsValueOption(label: .ui.system,
                                              value: UIUserInterfaceStyle.unspecified.rawValue,
                                              tapHandler: tapHandler)

        let darkModeOptions = [
            SettingsSection(options: [
                .value(option: offValue),
                .value(option: onValue),
                .value(option: systemValue),
            ]),
        ]

        let selectedValue = userPreferences.userInterfaceStyle.rawValue
        darkModeOptions.updateSelectedValue(selectedValue: selectedValue)
        return darkModeOptions
    }
}
