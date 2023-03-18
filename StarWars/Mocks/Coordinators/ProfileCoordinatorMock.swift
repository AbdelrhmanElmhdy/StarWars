//
//  HomeStackCoordinatorMock.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import UIKit

class HomeStackCoordinatorMock: Coordinator {
    var children = [Coordinator]()
    let navigationController = UINavigationController()

    func start() {
    }
}
