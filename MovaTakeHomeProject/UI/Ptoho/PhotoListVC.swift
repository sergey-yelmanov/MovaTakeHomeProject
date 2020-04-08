//
//  PhotoListVC.swift
//  MovaTakeHomeProject
//
//  Created by Sergey Yelmanov on 07.04.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit
import RealmSwift

enum State {
    case noData
    case dataDisplayed
}

final class PhotoListVC: UIViewController {
    
    // MARK: - UI Elements
    
    private let tableView = UITableView()
    private let noDataView = NoDataView(text: "No photos here yet...")
    private let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Properties
    
    private lazy var photos: Results<Photo> = { RealmService.shared.getPhotos() }()
    private var state = State.dataDisplayed
    private var notificationToken: NotificationToken?

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        subscribeForNotification()
        setupUI()
        setupGestures()
    }
    
    deinit {
        notificationToken?.invalidate()
    }
    
    // MARK: - SetupUI
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Photos"
        navigationItem.hidesSearchBarWhenScrolling = false
        
        setupTableView()
        setupNoDataView()
        setupSearchController()
        applyUI(state: photos.isEmpty ? .noData : .dataDisplayed)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.register(
            PhotoCell.self,
            forCellReuseIdentifier: String(describing: PhotoCell.self)
        )
        
        view.addSubview(tableView)
        
        tableView.pin(to: view)
    }
    
    private func setupNoDataView() {
        noDataView.alpha = 0
        view.addSubview(noDataView)
        
        noDataView.pin(to: view)
    }
    
    private func setupSearchController() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.autocapitalizationType = .none
        navigationItem.searchController = searchController
    }
    
    private func applyUI(state: State) {
        switch state {
        case .noData:
            UIView.animate(withDuration: 0.3) {
                self.noDataView.alpha = 1
            }

        case .dataDisplayed:
            noDataView.alpha = 0
        }

        self.state = state
    }
    
    // MARK: - Gestures
    
    private func setupGestures() {
        let hideKeyboardTapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(hideKeyboard)
        )
        view.addGestureRecognizer(hideKeyboardTapGesture)
    }
    
    // MARK: - Selectors
    
    @objc private func hideKeyboard() {
        searchController.isActive = false
        searchController.searchBar.resignFirstResponder()
    }
    
    // MARK: - Notifications
    
    private func subscribeForNotification() {
        notificationToken = try! Realm().observe { [weak self] (_, _) in
            guard let self = self else { return }
            self.applyUI(state: self.photos.isEmpty ? .noData : .dataDisplayed)
            self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .top)
        }
    }
    
    // MARK: - Networking
    
    private func getRandomPhoto(text: String) {
//        Router.shared.showLoading(in: view)
        
        PhotoService.shared.getRandomPhoto(withKeyword: text) { [weak self] result in
            guard let self = self else { return }
            
//            Router.shared.dismissLoading()
            
            switch result {
            case .success(let photo):
                RealmService.shared.addNewPhoto(photo)
            case .failure(let error):
                AlertService.showAlert(vc: self, title: error.localizedDescription)
            }
        }
    }

}

    // MARK: - Table view delegate

extension PhotoListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UIScreen.main.bounds.height / 3
    }
    
}

    // MARK: - Table view data source

extension PhotoListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: PhotoCell.self),
            for: indexPath) as! PhotoCell
        
        cell.setup(photo: photos[indexPath.row])
        
        return cell
    }
    
}

    // MARK: - Search bar delegate

extension PhotoListVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        getRandomPhoto(text: text)
        hideKeyboard()
    }
    
}
