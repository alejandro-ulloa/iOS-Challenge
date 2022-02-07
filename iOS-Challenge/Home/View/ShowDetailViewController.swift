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
    let genresTitleLabel = UILabel()
    let genresLabel = UILabel()
    
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
        topStackView.alignment = .top
        topStackView.spacing = 10
        mainStackView.addArrangedSubview(topStackView)
        
        showImageView.contentMode = .scaleAspectFit
        topStackView.addArrangedSubview(showImageView)
        
        detailStackView.axis = .vertical
        detailStackView.distribution = .fillProportionally
        detailStackView.alignment = .leading
        detailStackView.spacing = 10
        topStackView.addArrangedSubview(detailStackView)
        
        genresTitleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        detailStackView.addArrangedSubview(genresTitleLabel)
        
        genresLabel.numberOfLines = 0
        genresLabel.font = .systemFont(ofSize: 12)
        detailStackView.addArrangedSubview(genresLabel)
        
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
        genresTitleLabel.text = "genre_label".localized
        genresLabel.text = viewModel.show.genres?.joined(separator: ", ")
        summaryLabel.text = viewModel.show.summary?.htmlTransform()
    }
    
    func setUpConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        mainStackView.snp.makeConstraints {
            $0.edges.equalTo(view).inset(UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15))
        }
        
        topStackView.snp.makeConstraints {
            $0.width.equalTo(mainStackView)
            $0.height.equalTo(view).multipliedBy(0.35)
        }
        
        summaryLabel.snp.makeConstraints {
            $0.width.equalToSuperview()
        }
    }
    
    func bindViewModel() {
        
    }
}

