//
//  EpisodeDetailsViewController.swift
//  iOS-Challenge
//
//  Created by Alejandro Ulloa on 2022-02-07.
//

import Foundation
import UIKit
import SnapKit

final class EpisodeDetailsViewController: BaseViewController, BindableType {
    
    var viewModel: EpisodeDetailsViewModel!
    
    let contentView = UIView()
    let mainStackView = UIStackView()
    let descriptionView = UIView()
    let descriptionStackView = UIStackView()
    
    let episodeImageView = UIImageView()
    let nameTitleLabel = UILabel()
    let episodeNumberLabel = UILabel()
    let seasonLabel = UILabel()
    let summaryLabel = UILabel()
    
    func setUpViews() {
        contentView.backgroundColor = .transparentBlack
        contentView.layer.cornerRadius = 10
        view.addSubview(contentView)
        
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.alignment = .fill
        mainStackView.spacing = 20
        contentView.addSubview(mainStackView)
        
        episodeImageView.contentMode = .scaleAspectFit
        episodeImageView.layer.shadowColor = UIColor.white.cgColor
        episodeImageView.layer.shadowOpacity = 1
        episodeImageView.layer.shadowOffset = .zero
        episodeImageView.layer.shadowRadius = 10
        mainStackView.addArrangedSubview(episodeImageView)
        
        mainStackView.addArrangedSubview(descriptionView)
        descriptionStackView.axis = .vertical
        descriptionStackView.distribution = .fillProportionally
        descriptionStackView.alignment = .fill
        descriptionStackView.spacing = 10
        descriptionView.addSubview(descriptionStackView)
        
        nameTitleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        nameTitleLabel.textAlignment = .center
        nameTitleLabel.numberOfLines = 0
        descriptionStackView.addArrangedSubview(nameTitleLabel)
        
        seasonLabel.font = .systemFont(ofSize: 12, weight: .bold)
        descriptionStackView.addArrangedSubview(seasonLabel)
        
        episodeNumberLabel.font = .systemFont(ofSize: 12, weight: .bold)
        descriptionStackView.addArrangedSubview(episodeNumberLabel)
        
        summaryLabel.numberOfLines = 0
        summaryLabel.textAlignment = .justified
        summaryLabel.font = .systemFont(ofSize: 12)
        descriptionStackView.addArrangedSubview(summaryLabel)
    }
    
    func setUpLabels() {
        if let imageURLString = viewModel.episode.image?.original, let imageURL = URL(string: imageURLString) {
            episodeImageView.kf.setImage(with: imageURL)
        }
        
        summaryLabel.text = viewModel.episode.summary?.htmlTransform()
        nameTitleLabel.text = viewModel.episode.name
        episodeNumberLabel.text = "Episode \(viewModel.episode.number ?? 0)"
        seasonLabel.text = "Season \(viewModel.episode.season ?? 0)"
    }
    
    func setUpConstraints() {
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalToSuperview().multipliedBy(0.6)
            $0.center.equalToSuperview()
        }
        
        mainStackView.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.9)
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.center.equalToSuperview()
        }
        
        descriptionStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.lessThanOrEqualToSuperview()
        }
    }
    
    func bindViewModel() {
        
    }
    
}
