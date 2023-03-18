//
//  SettingsStackCoordination.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Foundation

protocol DisclosingSettings: AnyObject {
    func disclose(_ settingsDisclosureOption: SettingsDisclosureOption)
}
