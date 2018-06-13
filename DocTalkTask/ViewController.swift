//
//  ViewController.swift
//  DocTalkTask
//
//  Created by Raja Earla on 13/06/18.
//  Copyright © 2018 Raja Earla. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    private let tableView = UITableView()
    private let cellIdentifier = "UserTableViewCell"
    private let apiClient = APIManager()
    private let disposeBag = DisposeBag()
    
    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search User"
        return searchController
    }()
    
    var searchBar: UISearchBar { return searchController.searchBar }


    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setUpTableView()
        configureUserViewModel()
    }

    private func configureTableView() {
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        navigationItem.searchController = searchController
        navigationItem.title = "Git Hub Users"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setUpTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        tableView.contentInset.bottom = view.safeAreaInsets.bottom
    }
    
    private func configureUserViewModel () {
        
        searchBar.rx.text.orEmpty.asObservable()
            .map { ($0 ).lowercased() }
            .map { UserAPIRequest(name: $0) }
            .flatMap { request -> Observable<[User]> in
                return self.apiClient.send(apiRequest: request)
            }
            .bind(to: tableView.rx.items(cellIdentifier: cellIdentifier)) { index, model, cell in
                cell.textLabel?.text = model.login
                cell.textLabel?.adjustsFontSizeToFitWidth = true
            }
            .disposed(by: disposeBag)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}

