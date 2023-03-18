//
//  UIApplication+Ext.swift
//  CocoaToast
//
//  Created by Abdelrhman Elmahdy on 18/02/2023.
//

import UIKit

extension UIApplication {
    var keyWindow: UIWindow? {
        // Get connected scenes
        UIApplication.shared.connectedScenes
            // Keep only the first active scene, onscreen and visible to the user that is `UIWindowScene`
            .first(where: { $0.activationState == .foregroundActive && $0 is UIWindowScene })
            // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
            // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
}
