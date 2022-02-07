//
//  EpisodeTableViewCell.swift
//  iOS-Challenge
//
//  Created by Alejandro Ulloa on 2022-02-06.
//

import Foundation
import UIKit
import SnapKit

class EpisodeTableViewCell: UITableViewCell {
    
    static let identifier = "episodeCell"
    
    var episode: Episode?
    let nameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        setUpViews()
        setUpConstraints()
    }
    
    private func setUpViews() {
        contentView.addSubview(nameLabel)
    }
    
    private func setUpConstraints() {
        nameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(30)
        }
    }
    
    func setUp(episode: Episode) {
        self.episode = episode
        nameLabel.text = episode.name
    }
}
