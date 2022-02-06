//
//  ShowTableViewCell.swift
//  iOS-Challenge
//
//  Created by Alejandro Ulloa on 2022-02-06.
//

import Foundation
import UIKit
import SnapKit

class ShowTableViewCell: UITableViewCell {
    
    static let identifier = "showCell"
    
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
            $0.edges.equalToSuperview()
        }
    }
    
    func setUp(show: Show) {
        nameLabel.text = show.name
    }
    
    
    
}
