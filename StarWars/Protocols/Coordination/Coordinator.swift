//
//  Coordinator.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import UIKit

protocol Coordinator: AnyObject {
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get }

    func start()
    func startChild(_ child: Coordinator)
    func dismiss(animated: Bool)
    func childDidFinish(_ finishedChild: Coordinator)
    func removeChild(_ finishedChild: Coordinator)
}

extension Coordinator {
    func startChild(_ child: Coordinator) {
        children.append(child)
        child.start()
    }

    func childDidFinish(_ finishedChild: Coordinator) {
        finishedChild.dismiss(animated: true)
        removeChild(finishedChild)
    }

    func dismiss(animated: Bool) {
        navigationController.dismiss(animated: animated)
    }

    func removeChild(_ finishedChild: Coordinator) {
        // Loop over the children array and remove the finished coordinator.
        for (index, coordinator) in children.enumerated() where coordinator === finishedChild {
            children.remove(at: index)
            break
        }
    }
}
