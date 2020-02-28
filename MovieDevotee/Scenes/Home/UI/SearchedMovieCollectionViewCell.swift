//
//  SearchedMovieCollectionViewCell.swift
//  MovieDevotee
//
//  Created by Ryan on 2/26/20.
//  Copyright © 2020 Daylighter. All rights reserved.
//

import MagazineLayout

class SearchedMovieCollectionViewCell: MagazineLayoutCollectionViewCell {

    // MARK: Outlets
    
    private lazy var posterImageView: UIImageView = {
        let frame = CGRect(x: 0, y: 0, width: 200, height: 300)
        let imageView = UIImageView(frame: frame)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: .zero)

        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        
        return titleLabel
    }()
    
    private lazy var additionalInforLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        
        return label
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
        
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor),
        ])

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: additionalInforLabel.topAnchor),
        ])
        
        additionalInforLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            additionalInforLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            additionalInforLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            additionalInforLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
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
            contentView.backgroundColor = .lightGray
            additionalInfor = "TV Series " + additionalInfor
        case .movie:
            contentView.backgroundColor = .darkGray
        case .episode:
            contentView.backgroundColor = .gray
            additionalInfor = "Episode " + additionalInfor
        }
        
        additionalInforLabel.text = additionalInfor
        
        if let photoData = movie.photoData {
            let image = UIImage(data: photoData)
            posterImageView.image = image
        }
    }
}
