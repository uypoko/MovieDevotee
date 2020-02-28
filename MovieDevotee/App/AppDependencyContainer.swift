//
//  AppDependencyContainer.swift
//  MovieDevotee
//
//  Created by Ryan on 2/27/20.
//  Copyright © 2020 Daylighter. All rights reserved.
//

import Foundation
import UIKit

class AppDependencyContainer {
    
    let navigationController = UINavigationController()
    
    func constructRootVC() -> UIViewController {
        let homeContainer = HomeDependencyContainer(appDependencyContainer: self)
        return homeContainer.constructHomeVC()
    }
    
}
