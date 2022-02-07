//
//  HomeTabCoordinator.swift
//  iOS-Challenge
//
//  Created by Alejandro Ulloa on 2022-02-05.
//

import Foundation
import XCoordinator
import RxSwift

enum HomeTabRoute: Route {
    case shows
    case favourites
}

final class HomeTabCoordinator: TabBarCoordinator<HomeRoute> {
    
    init() {
        let homeCoordinator = HomeCoordinator()
        homeCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "shows_tab".localized, image: UIImage(systemName: "list.bullet"), tag: 0)
        
        let favouritesCoordinator = FavouritesCoordinator()
        favouritesCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "favourites_tab".localized, image: UIImage(systemName: "star.fill"), tag: 0)
        
        super.init(rootViewController: MainViewController(), tabs: [homeCoordinator.strongRouter, favouritesCoordinator.strongRouter],
                   select: homeCoordinator)
    }
}


class MainViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
}
