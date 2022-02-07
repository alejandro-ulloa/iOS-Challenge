//
//  ShowDetailViewController.swift
//  iOS-Challenge
//
//  Created by Alejandro Ulloa on 2022-02-06.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

final class ShowDetailViewController: BaseViewController, BindableType {
    
    var viewModel: ShowDetailViewModel!
    
    let scrollView = UIScrollView()
    let mainStackView = UIStackView()
    var showImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.sizeToFit()
    }
    
    func setUpViews() {
        view.addSubview(scrollView)
        
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillProportionally
        mainStackView.alignment = .top
        scrollView.addSubview(mainStackView)
        
        showImageView.contentMode = .scaleAspectFit
        view.addSubview(showImageView)

    }
    
    func setUpLabels() {
        navigationItem.title = viewModel.show.name
        if let imageURLString = viewModel.show.image?.original, let imageURL = URL(string: imageURLString) {
            showImageView.kf.setImage(with: imageURL)
        }
        
    }
    
    func setUpConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        mainStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        showImageView.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.85)
//            $0.width.equalTo(view)
        }
    }
    
    func bindViewModel() {
        
    }
}
