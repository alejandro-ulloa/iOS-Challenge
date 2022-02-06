//
//  ShowTableViewCell.swift
//  iOS-Challenge
//
//  Created by Alejandro Ulloa on 2022-02-06.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class ShowTableViewCell: UITableViewCell {
    
    static let identifier = "showCell"
    
    var show: Show?
    let showImageView = UIImageView()
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
        
        showImageView.contentMode = .scaleAspectFit
        contentView.addSubview(showImageView)
        
        contentView.addSubview(nameLabel)
        
    }
    
    private func setUpConstraints() {
        
        showImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(30)
            $0.width.equalTo(40)
        }
        
        nameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(showImageView.snp.trailing).offset(30)
        }
    }
    
    func setUp(show: Show) {
        self.show = show
        if let imageURLString = show.image?.medium, let imageURL = URL(string: imageURLString) {
            showImageView.kf.setImage(with: imageURL)
        }
        nameLabel.text = show.name
    }
    
    
    
}
