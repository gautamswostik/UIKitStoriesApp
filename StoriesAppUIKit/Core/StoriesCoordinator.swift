//
//  StoriesCoordinator.swift
//  StoriesAppUIKit
//
//  Created by swostik gautam on 07/07/2023.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinator: [Coordinator] {get}
    var navigationController: UINavigationController {get}
    func start()
}

class StoriesAppCoordinator: Coordinator {
    var childCoordinator: [Coordinator] = []
    
    var navigationController: UINavigationController = UINavigationController()
    
    func start() {
        let iniitialView = StoriesViewController()
        iniitialView.storiesCoordinator = self
        navigationController.pushViewController(iniitialView, animated: false)
        navigationController.navigationBar.prefersLargeTitles = true
    }
    
    func gotDetailsScreen(story: StoriesModel , color: UIColor) {
        let detailsView = StoryDetailView()
        detailsView.storiesCoordinator = self
        detailsView.story = story
        detailsView.color = color
        navigationController.pushViewController(detailsView, animated: true)
    }
}
