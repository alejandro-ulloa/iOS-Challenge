//
//  ViewController.swift
//  iOS-Challenge
//
//  Created by Alejandro Ulloa on 2022-02-02.
//

import UIKit
import SnapKit
import RxSwift

final class HomeViewController: BaseViewController, BindableType, UISearchControllerDelegate {
    
    var viewModel: HomeViewModel!
    
    let mainStackView = UIStackView()
    let searchController = UISearchController()
    let tableView = UITableView()
    
    let disposeBag = DisposeBag()
    
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
        navigationController?.navigationBar.sizeToFit()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func setUpViews() {
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillProportionally
        mainStackView.alignment = .center
        view.addSubview(mainStackView)
        
        tableView.rowHeight = 70
        tableView.register(ShowTableViewCell.self, forCellReuseIdentifier: ShowTableViewCell.identifier)
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
        
        viewModel
            .showsSubject
            .bind(to: tableView.rx.items(cellIdentifier: ShowTableViewCell.identifier, cellType: ShowTableViewCell.self)) { [weak self] row, element, cell in
                cell.setUp(show: element)
                guard let self = self else { return }
                if row == self.viewModel.shows.count - 1 {
                    self.viewModel.getNextPage()
                }
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                if let cell = self.tableView.cellForRow(at: indexPath) as? ShowTableViewCell {
                    self.viewModel.goToShowDetailsAction.execute(cell.show)
                }
            }).disposed(by: disposeBag)
        
    }
}
