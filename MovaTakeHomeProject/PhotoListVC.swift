//
//  PhotoListVC.swift
//  MovaTakeHomeProject
//
//  Created by Sergey Yelmanov on 07.04.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

final class PhotoListVC: UIViewController {
    
    private let tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupGestures()
    }
    
    // MARK: - SetupUI
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Photos"
        navigationItem.hidesSearchBarWhenScrolling = false
        
        setupTableView()
        setupSearchController()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.register(PhotoCell.self, forCellReuseIdentifier: String(describing: PhotoCell.self))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search photos"
        searchController.searchBar.autocapitalizationType = .none
        navigationItem.searchController = searchController
    }
    
    // MARK: - Gestures
    
    private func setupGestures() {
        let hideKeyboardTapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(hideKeyboardTapGesture)
    }
    
    // MARK: - Selectors
    
    @objc private func hideKeyboard() {
        searchController.isActive = false
        searchController.searchBar.resignFirstResponder()
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
        15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PhotoCell.self), for: indexPath) as! PhotoCell
        
        return cell
    }
    
}

    // MARK: - Search results updating

extension PhotoListVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
}
