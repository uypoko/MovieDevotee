//
//  ViewedMovieTableViewCell.swift
//  MovieDevotee
//
//  Created by Ryan on 3/4/20.
//  Copyright © 2020 Daylighter. All rights reserved.
//

import UIKit
import SDWebImage

class ViewedMovieTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var inforStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        
        return stackView
    }()

    private lazy var titleLabel: UILabel = {
        return uiviewFactory.makeSmallBoldLabel(alignment: .left)
    }()
    
    private lazy var additionalInforLabel: UILabel = {
        return uiviewFactory.makeSmallRegularLabel(alignment: .left)
    }()
    
    // MARK: Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupInitialViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View setups
    
    private func setupInitialViews() {
        contentView.addSubview(posterImageView)
        inforStackView.addArrangedSubview(titleLabel)
        inforStackView.addArrangedSubview(additionalInforLabel)
        contentView.addSubview(inforStackView)
        
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        inforStackView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        additionalInforLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let higherHuggingPriority = UILayoutPriority(rawValue: 252)
        let higherResistancePriority = UILayoutPriority(rawValue: 751)

        posterImageView.setContentHuggingPriority(higherHuggingPriority, for: .horizontal)
        inforStackView.setContentCompressionResistancePriority(higherResistancePriority, for: .horizontal)
        
        titleLabel.setContentCompressionResistancePriority(higherResistancePriority, for: .vertical)
        
        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            posterImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/5),
            posterImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1),
            
            inforStackView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 8),
            inforStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 8),
            inforStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            inforStackView.heightAnchor.constraint(lessThanOrEqualTo: contentView.heightAnchor, multiplier: 1),
        ])
    }
    
    func bind(movie: GeneralMovie) {
        titleLabel.text = movie.title
        var additionalInfor = movie.year
        
        switch movie.type {
        case .series:
            contentView.backgroundColor = .lightGray
            additionalInfor = "TV Series " + additionalInfor
        case .movie:
            contentView.backgroundColor = .darkGray
        case .episode:
            contentView.backgroundColor = .gray
            additionalInfor = "Episode " + additionalInfor
        }
        
        additionalInforLabel.text = additionalInfor
        
        posterImageView.sd_setImage(with: URL(string: movie.posterURLString), placeholderImage: UIImage(named: "placeholder.png"))
        
        layoutIfNeeded()
    }
}
