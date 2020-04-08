//
//  PhotoListVC.swift
//  MovaTakeHomeProject
//
//  Created by Sergey Yelmanov on 07.04.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit
import RealmSwift

final class PhotoListVC: BaseViewController {
    
    // MARK: - UI Elements
    
    private let tableView = UITableView()
    private let noDataView = NoDataView()
    private let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Properties
    
    private enum State {
        case noData
        case dataDisplayed
        case noResult
    }
    
    private lazy var photos: Results<Photo> = { RealmService.shared.getPhotos() }()
    private var state = State.dataDisplayed {
        didSet {
            updateUI()
        }
    }
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
        state = photos.isEmpty ? .noData : .dataDisplayed
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
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Cancel"
        searchController.searchBar.autocapitalizationType = .none
        navigationItem.searchController = searchController
    }
    
    // MARK: - UpdateUI
    
    private func updateUI() {
        DispatchQueue.main.async {
            switch self.state {
            case .noData:
                self.updateNoDataView(withText: "No photos here yet...", image: nil)
                self.updateComponents(true)
            case .noResult:
                self.updateNoDataView(withText: "No results found", image: UIImage(named: "no_results"))
                self.updateComponents(true)
            case .dataDisplayed:
                self.updateComponents(false)
            }
        }
    }
    
    private func updateNoDataView(withText text: String, image: UIImage?) {
        noDataView.setup(text: text, image: image)
    }
    
    private func updateComponents(_ isHidden: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.tableView.alpha = isHidden ? 0 : 1
            self.noDataView.alpha = isHidden ? 1 : 0
        }
    }
    
    // MARK: - Keyboard handling
    
    override func applyKeyboardAppearedWith(keyboardHeight: CGFloat) {
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
    }
    
    override func applyKeyboardDisappeared() {
        tableView.contentInset = .zero
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
            self.state = self.photos.isEmpty ? .noData : .dataDisplayed
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
                if let photo = photo {
                    RealmService.shared.addNewPhoto(photo)
                } else {
                    self.state = .noResult
                }
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
