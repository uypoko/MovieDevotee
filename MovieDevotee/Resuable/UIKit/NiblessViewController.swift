//
//  NiblessViewController.swift
//  MovieDevotee
//
//  Created by Ryan on 2/27/20.
//  Copyright © 2020 Daylighter. All rights reserved.
//

import UIKit

class NiblessViewController: UIViewController {
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable, message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection.")
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    @available(*, unavailable, message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection.")
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Loading this view controller from a nib is unsupported in favor of initializer dependency injection.")
    }
}
