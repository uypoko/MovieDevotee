//
//  SearchedMovieCollectionViewCell.swift
//  MovieDevotee
//
//  Created by Ryan on 2/26/20.
//  Copyright © 2020 Daylighter. All rights reserved.
//

import MagazineLayout
import SDWebImage

class SearchedMovieCollectionViewCell: MagazineLayoutCollectionViewCell {

    // MARK: Outlets
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        return uiviewFactory.makeSmallBoldLabel(alignment: .center)
    }()
    
    private lazy var additionalInforLabel: UILabel = {
        return uiviewFactory.makeSmallRegularLabel(alignment: .center)
    }()
    
    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(additionalInforLabel)
        
        posterImageView.setContentHuggingPriority(UILayoutPriority(rawValue: 252), for: .vertical)
        titleLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .vertical)
        additionalInforLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .vertical)
        
        titleLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .vertical)
        additionalInforLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .vertical)
        
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        additionalInforLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 4),
            
            additionalInforLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            additionalInforLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            additionalInforLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            additionalInforLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    override func prepareForReuse() {
      super.prepareForReuse()

      titleLabel.text = nil
      contentView.backgroundColor = nil
    }

    func set(_ movie: GeneralMovie) {
        titleLabel.text = movie.title
        var additionalInfor = movie.year
        
        switch movie.type {
        case .series:
            contentView.backgroundColor = .gray
            additionalInfor = "TV Series " + additionalInfor
        case .movie:
            contentView.backgroundColor = .darkGray
        case .episode:
            contentView.backgroundColor = .gray
            additionalInfor = "Episode " + additionalInfor
        }
        
        additionalInforLabel.text = additionalInfor
        
        posterImageView.sd_setImage(with: URL(string: movie.posterURLString), placeholderImage: UIImage(named: "placeholder.png"))
    }
}
