//
//  ViewController.swift
//  MovieDevotee
//
//  Created by Ryan on 2/24/20.
//  Copyright © 2020 Daylighter. All rights reserved.
//

import UIKit
import MagazineLayout
import RxSwift
import RxCocoa

class HomeViewController: NiblessViewController {
    
    //MARK: UI Controls
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .prominent
        searchBar.placeholder = "Search by title"
        searchBar.sizeToFit()
        
        return searchBar
    }()
    
    private lazy var movieCollectionView: MagazineCollectionView = {
        let layout = MagazineLayout()
        let collectionView = MagazineCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPrefetchingEnabled = false
        collectionView.backgroundColor = .black
        collectionView.contentInsetAdjustmentBehavior = .automatic
        collectionView.autoresizesSubviews = false
        
        return collectionView
    }()
    
    // MARK: Properties
    private let viewModel: HomeViewModel

    private let disposeBag = DisposeBag()
    
    // MARK: Lifecycle
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupInitialViews()
        bindToViewModel()
        subscribe()
    }
    
    // MARK: View Setups
    
    private func setupInitialViews() {
        navigationItem.titleView = searchBar
        view.addSubview(movieCollectionView)
        
        movieCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        movieCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        movieCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        movieCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        movieCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        movieCollectionView.register(SearchedMovieCollectionViewCell.self, forCellWithReuseIdentifier: SearchedMovieCollectionViewCell.description())
        
        movieCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
    }
    
    // MARK: Bindings
    
    private func subscribe() {
        viewModel.moviesSubject
            .asDriver(onErrorJustReturn: [])
            .drive(movieCollectionView.rx.items) { (collectionView, index, movie) in
                let indexPath = IndexPath(row: index, section: 0)
                
                guard let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(SearchedMovieCollectionViewCell.description())", for: indexPath) as? SearchedMovieCollectionViewCell else {
                    fatalError("Failed to cast to SearchedMovieCollectionViewCell")
                }
                
                movieCell.set(movie)
                
                return movieCell
            }
            .disposed(by: disposeBag)
        
    }
    
    private func bindToViewModel() {
        searchBar.rx.text
            .map { $0 ?? "" }
            .filter { $0 != "" }
            .bind(to: viewModel.searchedKeywordsSubject)
            .disposed(by: disposeBag)
        
        //movieCollectionView.rx.item
    }
    
}

// MARK: UICollectionViewDelegateMagazineLayout

extension HomeViewController: UICollectionViewDelegateMagazineLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeModeForItemAt indexPath: IndexPath) -> MagazineLayoutItemSizeMode {
        let widthMode = MagazineLayoutItemWidthMode.halfWidth
        let viewHeight = view.frame.height
        let heightMode = MagazineLayoutItemHeightMode.static(height: viewHeight / 3)
        return MagazineLayoutItemSizeMode(widthMode: widthMode, heightMode: heightMode)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, visibilityModeForHeaderInSectionAtIndex index: Int) -> MagazineLayoutHeaderVisibilityMode {
        return .hidden
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, visibilityModeForFooterInSectionAtIndex index: Int) -> MagazineLayoutFooterVisibilityMode {
        return .hidden
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, visibilityModeForBackgroundInSectionAtIndex index: Int) -> MagazineLayoutBackgroundVisibilityMode {
        return .hidden
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, horizontalSpacingForItemsInSectionAtIndex index: Int) -> CGFloat {
        return  12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, verticalSpacingForElementsInSectionAtIndex index: Int) -> CGFloat {
        return  12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetsForSectionAtIndex index: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetsForItemsInSectionAtIndex index: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    }
    
}

