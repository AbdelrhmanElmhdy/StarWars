//
//  ViewControllerAndViewModelBinder.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Combine
import UIKit

class ViewControllerAndViewModelBinder<ViewController: UIViewController, ViewModel: AnyObject> {
    let viewController: ViewController
    let viewModel: ViewModel

    var subscriptions: Set<AnyCancellable> = []

    init(viewController: ViewController, viewModel: ViewModel) {
        self.viewController = viewController
        self.viewModel = viewModel
    }

    // Abstract
    func setupBindings() {
    }

    func removeBindings() {
        subscriptions.removeAll()
    }
}
