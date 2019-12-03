//
//  VideoCell.swift
//  Temp
//
//  Created by Egor Syrtcov on 03/12/2019.
//  Copyright © 2019 Egor Syrtcov. All rights reserved.
//

import UIKit

class VideoCell: UICollectionViewCell {
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        return imageView
    }()
    
    let seporatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        assemble()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func assemble() {
        addSubview(thumbnailImageView)
        addSubview(userProfileImageView)
        addSubview(seporatorView)
    }
    
    private func setupLayout() {
        thumbnailImageView.snp.makeConstraints { (make) in
            make.topMargin.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-60)
        }
        
        userProfileImageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 50, height: 50))
            make.left.equalTo(thumbnailImageView)
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(5)
        }
        
        seporatorView.snp.makeConstraints { (make) in
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.height.equalTo(1)
            make.bottom.equalTo(snp.bottom)
        }
    }
    
}
