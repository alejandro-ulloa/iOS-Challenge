//
//  ViewController.swift
//  iOS-Challenge
//
//  Created by Alejandro Ulloa on 2022-02-02.
//

import UIKit
import SnapKit

final class HomeViewController: BaseViewController, BindableType, UISearchBarDelegate {
    
    var viewModel: HomeViewModel!
    
    let mainStackView = UIStackView()
    let searchBar = UISearchBar()
    
    func setUpViews() {
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillProportionally
        mainStackView.alignment = .center
        mainStackView.backgroundColor = .white
        view.addSubview(mainStackView)
        
        searchBar.delegate = self
        mainStackView.addArrangedSubview(searchBar)
    }
    
    func setUpLabels() {
        
    }
    
    func setUpConstraints() {
        mainStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        searchBar.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(60)
        }
    }
    
    func bindViewModel() {
        
        
    }
}
