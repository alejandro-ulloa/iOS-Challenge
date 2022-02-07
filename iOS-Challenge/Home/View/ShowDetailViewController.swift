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
    
    let topStackView = UIStackView()
    let showImageView = UIImageView()
    let detailStackView = UIStackView()
    
    let summaryLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
    }
    
    func setUpViews() {
        view.addSubview(scrollView)
        
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillProportionally
        mainStackView.alignment = .center
        mainStackView.spacing = 20
        scrollView.addSubview(mainStackView)
        
        topStackView.axis = .horizontal
        topStackView.distribution = .fillEqually
        topStackView.alignment = .center
        topStackView.spacing = 10
        mainStackView.addArrangedSubview(topStackView)
        
        showImageView.contentMode = .scaleAspectFit
        topStackView.addArrangedSubview(showImageView)
        
        detailStackView.axis = .vertical
        detailStackView.distribution = .fillProportionally
        detailStackView.alignment = .center
        detailStackView.backgroundColor = .red
        topStackView.addArrangedSubview(detailStackView)
        
        summaryLabel.numberOfLines = 0
        summaryLabel.textAlignment = .justified
        summaryLabel.font = .systemFont(ofSize: 12)
        mainStackView.addArrangedSubview(summaryLabel)
        
    }
    
    func setUpLabels() {
        navigationItem.title = viewModel.show.name
        if let imageURLString = viewModel.show.image?.original, let imageURL = URL(string: imageURLString) {
            showImageView.kf.setImage(with: imageURL)
        }
        summaryLabel.text = viewModel.show.summary?.htmlTransform()
    }
    
    func setUpConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        mainStackView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
        
        topStackView.snp.makeConstraints {
            $0.width.equalTo(mainStackView).multipliedBy(0.9)
            $0.height.equalTo(view).multipliedBy(0.4)
        }
        
        detailStackView.snp.makeConstraints {
            $0.height.equalToSuperview()
        }
        
        summaryLabel.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
        }
    }
    
    func bindViewModel() {
        
    }
}

