//
//  ViewControllersFactory.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Foundation

protocol HomeViewControllersFactory: AnyObject {
    func makeHomeViewController(for coordinator: Coordinator) -> HomeViewController
}

protocol SettingsViewControllersFactory: AnyObject {
    func makeSettingsViewController(for coordinator: DisclosingSettings,
                                    settingsSections: [SettingsSection]?) -> SettingsViewController
}

typealias ViewControllersFactory = HomeViewControllersFactory & SettingsViewControllersFactory
