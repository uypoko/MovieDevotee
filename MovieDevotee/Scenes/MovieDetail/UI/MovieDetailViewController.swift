//
//  MovieDetailViewController.swift
//  MovieDevotee
//
//  Created by Ryan on 2/28/20.
//  Copyright © 2020 Daylighter. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class MovieDetailViewController: NiblessViewController {
    
    //MARK: UI Controls
    
    private let scrollView = UIScrollView()
    
    private lazy var wrapperView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkThemeColor
        
        return view
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        return uiviewFactory.makeWhiteLargeIndicator()
    }()
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var rightInforView: UIView = {
        return UIView()
    }()
    
    private lazy var titleLabel: UILabel = {
        return uiviewFactory.makeLargeBoldLabel(alignment: .left)
    }()
    
    private lazy var yearRatedLengthStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var yearLabel: UILabel = {
        return uiviewFactory.makeMediumRegularLabel(alignment: .left)
    }()
    
    private lazy var ratedLabel: UILabel = {
        return uiviewFactory.makeMediumRegularLabel(alignment: .left)
    }()
    
    private lazy var lengthLabel: UILabel = {
        return uiviewFactory.makeMediumRegularLabel(alignment: .left)
    }()
    
    private lazy var genreScrollView: UIScrollView = {
        return UIScrollView()
    }()
    
    private lazy var genreStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var releaseDateLabel: UILabel = {
        return uiviewFactory.makeMediumRegularLabel(alignment: .left)
    }()
    
    private lazy var detailWrapperView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    private lazy var ratingsWrapperView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    private lazy var ratingsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var imdbRatingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 2
        return stackView
    }()
    
    private lazy var imdbRatingLabel: UILabel = {
        let label = uiviewFactory.makeMediumRegularLabel(alignment: .center)
        label.text = "⭐️"
        
        return label
    }()
    
    private lazy var imdbRatingValueLabel: UILabel = {
        let label = uiviewFactory.makeMediumRegularLabel(alignment: .center)
        
        return label
    }()
    
    private lazy var rottenStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 2
        return stackView
    }()
    
    private lazy var rottenRatingLabel: UILabel = {
        let label = uiviewFactory.makeMediumRegularLabel(alignment: .center)
        label.text = "🍅"
        
        return label
    }()
    
    private lazy var rottenRatingValueLabel: UILabel = {
        let label = uiviewFactory.makeMediumRegularLabel(alignment: .center)
        
        return label
    }()
    
    private lazy var metaRatingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 2
        return stackView
    }()
    
    private lazy var metaRatingLabel: UILabel = {
        let label = uiviewFactory.makeMediumRegularLabel(alignment: .center)
        label.text = "Metascore"
        
        return label
    }()
    
    private lazy var metaRatingValueLabel: UILabel = {
        let label = uiviewFactory.makeMediumRegularLabel(alignment: .center)
        label.text = "00"
        label.backgroundColor = .green
        
        return label
    }()
    
    private lazy var detailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var separatorView1: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var separatorView2: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var separatorView3: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var plotLabel: UILabel = {
        return uiviewFactory.makeMediumRegularLabel(alignment: .left)
    }()
    
    private lazy var directorLabel: UILabel = {
        return uiviewFactory.makeMediumRegularLabel(alignment: .left)
    }()
    
    private lazy var writerLabel: UILabel = {
        return uiviewFactory.makeMediumRegularLabel(alignment: .left)
    }()
    
    private lazy var castLabel: UILabel = {
        return uiviewFactory.makeMediumRegularLabel(alignment: .left)
    }()
    
    // MARK: Properties
    private let viewModel: MovieDetailViewModel

    private let disposeBag = DisposeBag()
    
    // MARK: Lifecycle
    
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialViews()
        bindFromViewModel()
    }
    
    // MARK: View Setups
    private func setupInitialViews() {
        view.addSubview(activityIndicator)
        scrollView.addSubview(wrapperView)
        view.addSubview(scrollView)
        
        // Overview
        wrapperView.addSubview(posterImageView)
        
        yearRatedLengthStackView.addArrangedSubview(yearLabel)
        yearRatedLengthStackView.addArrangedSubview(ratedLabel)
        yearRatedLengthStackView.addArrangedSubview(lengthLabel)
        
        rightInforView.addSubview(titleLabel)
        rightInforView.addSubview(yearRatedLengthStackView)
        genreScrollView.addSubview(genreStackView)
        rightInforView.addSubview(genreScrollView)
        rightInforView.addSubview(releaseDateLabel)
        wrapperView.addSubview(rightInforView)
        
        // Ratings
        imdbRatingStackView.addArrangedSubview(imdbRatingLabel)
        imdbRatingStackView.addArrangedSubview(imdbRatingValueLabel)
        rottenStackView.addArrangedSubview(rottenRatingLabel)
        rottenStackView.addArrangedSubview(rottenRatingValueLabel)
        metaRatingStackView.addArrangedSubview(metaRatingValueLabel)
        metaRatingStackView.addArrangedSubview(metaRatingLabel)
        ratingsStackView.addArrangedSubview(imdbRatingStackView)
        ratingsStackView.addArrangedSubview(rottenStackView)
        ratingsStackView.addArrangedSubview(metaRatingStackView)
        ratingsWrapperView.addSubview(ratingsStackView)
        wrapperView.addSubview(ratingsWrapperView)
        
        // Details
        detailStackView.addArrangedSubview(plotLabel)
        detailStackView.addArrangedSubview(separatorView1)
        detailStackView.addArrangedSubview(directorLabel)
        detailStackView.addArrangedSubview(separatorView2)
        detailStackView.addArrangedSubview(writerLabel)
        detailStackView.addArrangedSubview(separatorView3)
        detailStackView.addArrangedSubview(castLabel)
        detailWrapperView.addSubview(detailStackView)
        wrapperView.addSubview(detailWrapperView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        rightInforView.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        ratedLabel.translatesAutoresizingMaskIntoConstraints = false
        lengthLabel.translatesAutoresizingMaskIntoConstraints = false
        yearRatedLengthStackView.translatesAutoresizingMaskIntoConstraints = false
        genreStackView.translatesAutoresizingMaskIntoConstraints = false
        genreScrollView.translatesAutoresizingMaskIntoConstraints = false
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        ratingsStackView.translatesAutoresizingMaskIntoConstraints = false
        ratingsWrapperView.translatesAutoresizingMaskIntoConstraints = false
        
        detailStackView.translatesAutoresizingMaskIntoConstraints = false
        detailWrapperView.translatesAutoresizingMaskIntoConstraints = false
        plotLabel.translatesAutoresizingMaskIntoConstraints = false
        directorLabel.translatesAutoresizingMaskIntoConstraints = false
        writerLabel.translatesAutoresizingMaskIntoConstraints = false
        castLabel.translatesAutoresizingMaskIntoConstraints = false
        separatorView1.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.setContentHuggingPriority(UILayoutPriority(252), for: .vertical)
        posterImageView.setContentHuggingPriority(UILayoutPriority(rawValue: 252), for: .horizontal)
        rightInforView.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
        
        yearRatedLengthStackView.setContentHuggingPriority(UILayoutPriority(251), for: .vertical)
        genreStackView.setContentHuggingPriority(UILayoutPriority(251), for: .vertical)
        
        view.backgroundColor = .darkThemeColor
        activityIndicator.center = view.center
        
        let genreStackViewWidthCons = NSLayoutConstraint(item: genreStackView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 3/4, constant: 0)
        genreStackViewWidthCons.priority = UILayoutPriority(rawValue: 250)
        genreStackViewWidthCons.isActive = true
        
        wrapperView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            wrapperView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            wrapperView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            wrapperView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            wrapperView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            wrapperView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            posterImageView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 8),
            posterImageView.topAnchor.constraint(equalTo: wrapperView.topAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: view.frame.width / 4),
            posterImageView.heightAnchor.constraint(equalToConstant: view.frame.height / 5),
            
            rightInforView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 12),
            rightInforView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -8),
            rightInforView.topAnchor.constraint(equalTo: wrapperView.safeAreaLayoutGuide.topAnchor, constant: 8),
            rightInforView.heightAnchor.constraint(equalToConstant: view.frame.height / 5),
            
            titleLabel.leadingAnchor.constraint(equalTo: rightInforView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: rightInforView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: rightInforView.topAnchor),
            
            yearRatedLengthStackView.leadingAnchor.constraint(equalTo: rightInforView.leadingAnchor),
            //yearRatedLengthStackView.trailingAnchor.constraint(equalTo: rightInforView.trailingAnchor),
            yearRatedLengthStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            
            genreScrollView.leadingAnchor.constraint(equalTo: rightInforView.leadingAnchor),
            genreScrollView.trailingAnchor.constraint(equalTo: rightInforView.trailingAnchor),
            genreScrollView.topAnchor.constraint(equalTo: yearRatedLengthStackView.bottomAnchor, constant: 8),
            
            genreStackView.leadingAnchor.constraint(equalTo: genreScrollView.leadingAnchor),
            genreStackView.trailingAnchor.constraint(equalTo: genreScrollView.trailingAnchor),
            genreStackView.topAnchor.constraint(equalTo: genreScrollView.topAnchor),
            genreStackView.bottomAnchor.constraint(equalTo: genreScrollView.bottomAnchor),
            genreStackView.heightAnchor.constraint(equalTo: genreScrollView.heightAnchor),
            
            releaseDateLabel.leadingAnchor.constraint(equalTo: rightInforView.leadingAnchor),
            releaseDateLabel.trailingAnchor.constraint(equalTo: rightInforView.trailingAnchor),
            releaseDateLabel.topAnchor.constraint(equalTo: genreScrollView.bottomAnchor, constant: 8),
            
            ratingsWrapperView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor),
            ratingsWrapperView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor),
            ratingsWrapperView.topAnchor.constraint(equalTo: rightInforView.bottomAnchor),
            
            ratingsStackView.leadingAnchor.constraint(equalTo: ratingsWrapperView.leadingAnchor, constant: 8),
            ratingsStackView.trailingAnchor.constraint(equalTo: ratingsWrapperView.trailingAnchor, constant: -8),
            ratingsStackView.topAnchor.constraint(equalTo: ratingsWrapperView.topAnchor, constant: 8),
            ratingsStackView.bottomAnchor.constraint(equalTo: ratingsWrapperView.bottomAnchor, constant: -8),
            
            detailWrapperView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor),
            detailWrapperView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor),
            detailWrapperView.topAnchor.constraint(equalTo: ratingsWrapperView.bottomAnchor, constant: 8),
            detailWrapperView.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor),
            
            detailStackView.leadingAnchor.constraint(equalTo: detailWrapperView.leadingAnchor, constant: 8),
            detailStackView.trailingAnchor.constraint(equalTo: detailWrapperView.trailingAnchor, constant: -8),
            detailStackView.topAnchor.constraint(equalTo: detailWrapperView.topAnchor, constant: 8),
            detailStackView.bottomAnchor.constraint(equalTo: detailWrapperView.bottomAnchor, constant: -8),
            
            separatorView1.widthAnchor.constraint(equalTo: detailStackView.widthAnchor, multiplier: 1),
            separatorView2.widthAnchor.constraint(equalTo: detailStackView.widthAnchor, multiplier: 1),
            separatorView3.widthAnchor.constraint(equalTo: detailStackView.widthAnchor, multiplier: 1),
        ])
        
    }
    
    private func setUpGenreStackView(genres: [String]) {
        var genreLabels: [UILabel] = []
        
        for index in 0..<genres.count {
            let genreLabel = uiviewFactory.makeMediumRegularLabel(alignment: .left)
            genreLabel.text = genres[index]
            genreStackView.addSubview(genreLabel)
            
            genreLabel.layer.borderColor = UIColor.white.cgColor
            genreLabel.layer.borderWidth = 0.5
            
            genreLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                genreLabel.topAnchor.constraint(equalTo: genreStackView.topAnchor),
                genreLabel.bottomAnchor.constraint(equalTo: genreStackView.bottomAnchor),
            ])
            
            if index == 0 {
                genreLabel.setContentHuggingPriority(UILayoutPriority(252), for: .horizontal)
                
                NSLayoutConstraint.activate([
                    genreLabel.leadingAnchor.constraint(equalTo: genreStackView.leadingAnchor),
                ])
            }
             else {
                NSLayoutConstraint.activate([
                    genreLabel.leadingAnchor.constraint(equalTo: genreLabels[genreLabels.count - 1].trailingAnchor, constant: 8),
                ])
            }
            
            genreLabels.append(genreLabel)
        }
    }
    
    // MARK: Bindings
    
    private func bindFromViewModel() {
        
        viewModel.posterURLSubject
            .subscribe(
                onNext: { [weak self] url in
                    guard let self = self else { return }
                    
                    self.posterImageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder.png"))
                }
            )
            .disposed(by: disposeBag)
        
        let activityIndicatorAnimating = viewModel.activityIndicatorAnimating.asDriver(onErrorJustReturn: false)
        
        activityIndicatorAnimating
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        activityIndicatorAnimating
            .drive(wrapperView.rx.isHidden)
            .disposed(by: disposeBag)
        
        //activityIndicatorAnimating
            //.drive(detailWrapperView.rx.isHidden)
            //.disposed(by: disposeBag)
        
        viewModel.titleSubject
            .asDriver(onErrorJustReturn: "")
            .drive(titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.yearSubject
            .asDriver(onErrorJustReturn: "")
            .drive(yearLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.ratedSubject
            .asDriver(onErrorJustReturn: "")
            .drive(ratedLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.lengthSubject
            .asDriver(onErrorJustReturn: "")
            .drive(lengthLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.genresSubject
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] genres in
                guard let self = self else { return }
                
                self.setUpGenreStackView(genres: genres)
            })
            .disposed(by: disposeBag)
        
        viewModel.releaseDateSubject
            .map { "Release Date: " + $0 }
            .asDriver(onErrorJustReturn: "")
            .drive(releaseDateLabel.rx.text)
            .disposed(by: disposeBag)
        
        // Ratings
        viewModel.imdbRatingSubject
            .asDriver(onErrorJustReturn: "0.0/10")
            .drive(imdbRatingValueLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.rottenRatingSubject
            .asDriver(onErrorJustReturn: "0%")
            .drive(rottenRatingValueLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.metaRatingSubject
            .map { $0?.components(separatedBy: "/")[0] }
            .asDriver(onErrorJustReturn: "00")
            .drive(metaRatingValueLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.rottenRatingSubject
            .map { $0 == nil }
            .asDriver(onErrorJustReturn: true)
            .drive(rottenStackView.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.metaRatingSubject
            .map { $0 == nil }
            .asDriver(onErrorJustReturn: true)
            .drive(metaRatingStackView.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.plotSubject
            .map { "Plot: " + $0 }
            .asDriver(onErrorJustReturn: "")
            .drive(plotLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.directorSubject
            .map { "Directors: " + $0 }
            .asDriver(onErrorJustReturn: "")
            .drive(directorLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.writerSubject
            .map { "Writers: "  + $0.joined(separator: ", ") }
            .asDriver(onErrorJustReturn: "")
            .drive(writerLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.castSubject
            .map { "Cast: "  + $0.joined(separator: ", ") }
            .asDriver(onErrorJustReturn: "")
            .drive(castLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
