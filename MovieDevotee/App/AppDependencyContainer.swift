//
//  AppDependencyContainer.swift
//  MovieDevotee
//
//  Created by Ryan on 2/27/20.
//  Copyright © 2020 Daylighter. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class AppDependencyContainer {
    
    //let navigationController = UINavigationController()
    // Long-lived singleton dependencies
    let utilityPrioritizedConcurrentQueue = ConcurrentDispatchQueueScheduler.init(qos: .utility)
    lazy var movieDataStore: MovieDataStore = {
        let pathFactory = PathFactory()
        let realmFactory = RealmFactory(
            pathFactory: pathFactory)
        let dataStore = MovieDataStore(realmFactory: realmFactory)
        
        return dataStore
    }()
    
    func constructRootVC() -> UIViewController {
        let tabBarVC = UITabBarController()
        
        let searchContainer = SearchDependencyContainer(appDependencyContainer: self)
        let searchVC = searchContainer.constructSearchVC()
        let searchTabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        searchVC.tabBarItem = searchTabBarItem
        
        let userContainer = UserManagementContainer(appDependencyContainer: self)
        let userVC = userContainer.constructUserManagementVC()
        let userTabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
        userVC.tabBarItem = userTabBarItem
        
        tabBarVC.viewControllers = [searchVC, userVC]
        return tabBarVC
    }
    
}
