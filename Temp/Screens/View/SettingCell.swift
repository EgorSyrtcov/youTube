//
//  SettingCell.swift
//  Temp
//
//  Created by Egor Syrtcov on 12/17/19.
//  Copyright © 2019 Egor Syrtcov. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .darkGray : .white
            nameLabel.textColor = isHighlighted ? .white : .black
            iconImageView.tintColor = isHighlighted ? .white : .darkGray
        }
    }
    
    var setting : Setting? {
        didSet {
            guard let setting = setting else {return}
            iconImageView.image = UIImage(named: setting.imageName)?.withRenderingMode(.alwaysTemplate)
            iconImageView.tintColor = .darkGray
            nameLabel.text = setting.name.rawValue
        }
    }
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let tl = UILabel()
        tl.font = UIFont.systemFont(ofSize: 13)
        return tl
    }()
    
    override func setupView() {
        super.setupView()
        
        assemble()
    }
    
    private func assemble() {
        addSubview(iconImageView)
        addSubview(nameLabel)
        setupLayout()
    }
    
    private func setupLayout() {
        iconImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.centerY.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(10)
            make.bottom.equalTo(iconImageView)
        }
    }
            
}
