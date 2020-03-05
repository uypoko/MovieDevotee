//
//  UIViewFactory.swift
//  MovieDevotee
//
//  Created by Ryan on 3/1/20.
//  Copyright © 2020 Daylighter. All rights reserved.
//

import UIKit

class UIViewFactory {
    
    // MARK: UILabel
    func makeSmallBoldLabel(alignment: NSTextAlignment) -> UILabel {
        let label = UILabel(frame: .zero)

        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = alignment
        label.textColor = .white
        label.numberOfLines = 0
        
        return label
    }
    
    func makeMediumBoldLabel(alignment: NSTextAlignment) -> UILabel {
        let label = UILabel(frame: .zero)

        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = alignment
        label.textColor = .white
        label.numberOfLines = 0
        
        return label
    }
    
    func makeSmallRegularLabel(alignment: NSTextAlignment) -> UILabel {
        let label = UILabel(frame: .zero)

        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = alignment
        label.textColor = .white
        label.numberOfLines = 0
        
        return label
    }
    
    func makeMediumRegularLabel(alignment: NSTextAlignment) -> UILabel {
        let label = UILabel(frame: .zero)

        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = alignment
        label.textColor = .white
        label.numberOfLines = 0
        
        return label
    }
    
    // MARK: UIStackView
    func makeFillStackView(axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        return stackView
    }
    
    // MARK: Activity Indicator
    func makeWhiteLargeIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = .white
        activityIndicator.style = .large
        
        return activityIndicator
    }
}
