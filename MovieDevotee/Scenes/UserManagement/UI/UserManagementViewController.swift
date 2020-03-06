//
//  UserManagementViewController.swift
//  MovieDevotee
//
//  Created by Ryan on 3/4/20.
//  Copyright © 2020 Daylighter. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxRealm

class UserManagementViewController: NiblessViewController {
    
    // MARK: UI Controls
    private lazy var recentlyViewedMoviesLabel: UILabel = {
        let label = uiviewFactory.makeMediumBoldLabel(alignment: .left)
        label.text = "Recently Viewed"
        return label
    }()
    
    private lazy var viewedMoviesTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.backgroundColor = .darkGray
        return tableView
    }()
    
    private let viewModel: UserManagementViewModel
    
    private let disposeBag = DisposeBag()
    private let movieCellIdentifier = "MovieCell"
    
    // MARK: Lifecycle
    
    init(viewModel: UserManagementViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewedMoviesTableView.register(ViewedMovieTableViewCell.self, forCellReuseIdentifier: movieCellIdentifier)
        
        setupInitialViews()
        bindToTableView()
        bindToViewModel()
    }
    
    // MARK: View Setups
    
    private func setupInitialViews() {
        view.addSubview(recentlyViewedMoviesLabel)
        view.addSubview(viewedMoviesTableView)
        
        recentlyViewedMoviesLabel.translatesAutoresizingMaskIntoConstraints = false
        viewedMoviesTableView.translatesAutoresizingMaskIntoConstraints = false
        
        viewedMoviesTableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        view.backgroundColor = .darkThemeColor
        
        NSLayoutConstraint.activate([
            recentlyViewedMoviesLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            recentlyViewedMoviesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            recentlyViewedMoviesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 8),
            
            viewedMoviesTableView.topAnchor.constraint(equalTo: recentlyViewedMoviesLabel.bottomAnchor, constant: 8),
            viewedMoviesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewedMoviesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewedMoviesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
    
    // MARK: Bindings
    private func bindToTableView() {
        //guard let recentlyViewedMovies = viewModel.recentlyViewedMovies else { return }
        
        Observable.collection(from: viewModel.recentlyViewedMovies)
            .observeOn(MainScheduler.instance)
            .bind(to: viewedMoviesTableView.rx.items(
                cellIdentifier: movieCellIdentifier,
                cellType: ViewedMovieTableViewCell.self)) { index, movie, cell in
                    cell.bind(movie: movie)
                }
            .disposed(by: disposeBag)
        
    }
    
    private func bindToViewModel() {
        viewedMoviesTableView.rx.modelSelected(GeneralMovie.self)
            .asDriver()
            .drive(viewModel.movieCellTapped)
            .disposed(by: disposeBag)
        
        
    }
}

// MARK: UITableview Delegate
extension UserManagementViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
