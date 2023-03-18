//
//  UINavigationController+Ext.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import UIKit

extension UINavigationController {
    var previousViewController: UIViewController? {
        guard viewControllers.count >= 2 else {
            return nil
        }

        let previousVCIndex = viewControllers.count - 2
        let previousVC = viewControllers[previousVCIndex]

        return previousVC
    }
}
