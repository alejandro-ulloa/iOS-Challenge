//
//  FavouritesViewController.swift
//  iOS-Challenge
//
//  Created by Alejandro Ulloa on 2022-02-07.
//

import UIKit
import SnapKit
import RxSwift

final class FavouritesViewController: BaseViewController, BindableType, UITableViewDelegate {

    var viewModel: FavouritesViewModel!

    let mainStackView = UIStackView()
    let tableView = UITableView()

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = "favourites_title".localized
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.sizeToFit()
        viewModel.loadFavourites()
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
        tableView.delegate = self
        tableView.register(ShowTableViewCell.self, forCellReuseIdentifier: ShowTableViewCell.identifier)
        mainStackView.addArrangedSubview(tableView)
    }

    func setUpLabels() {

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
            .bind(to: tableView.rx.items(cellIdentifier: ShowTableViewCell.identifier, cellType: ShowTableViewCell.self)) { row, element, cell in
                cell.setUp(show: element)
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



    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
            -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] (_, _, completionHandler) in
                // delete the item here
                self?.viewModel.removeFavouriteFrom(index: indexPath.row)
                self?.viewModel.loadFavourites()
                completionHandler(true)
            }
            deleteAction.image = UIImage(systemName: "trash")
            deleteAction.backgroundColor = .systemRed
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            return configuration
    }
}
