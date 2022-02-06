//
//  ViewController.swift
//  iOS-Challenge
//
//  Created by Alejandro Ulloa on 2022-02-02.
//

import UIKit
import SnapKit

final class HomeViewController: BaseViewController, BindableType, UISearchControllerDelegate {
    
    var viewModel: HomeViewModel!
    
    let mainStackView = UIStackView()
    let searchController = UISearchController()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.delegate = self
        searchController.hidesNavigationBarDuringPresentation = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = "shows_title".localized
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController!.navigationBar.sizeToFit()
    }
    
    func setUpViews() {
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillProportionally
        mainStackView.alignment = .center
        mainStackView.backgroundColor = .white
        view.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(tableView)
    }
    
    func setUpLabels() {
        searchController.searchBar.placeholder = "search_plceholder".localized
    }
    
    func setUpConstraints() {
        mainStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func bindViewModel() {
        
        
    }
}
