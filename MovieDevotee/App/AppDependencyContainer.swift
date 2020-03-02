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
    
    let navigationController = UINavigationController()
    // Long-lived singleton dependencies
    let utilityPrioritizedConcurrentQueue = ConcurrentDispatchQueueScheduler.init(qos: .utility)
    
    func constructRootVC() -> UIViewController {
        let searchContainer = SearchDependencyContainer(appDependencyContainer: self)
        return searchContainer.constructSearchVC()
    }
    
}
