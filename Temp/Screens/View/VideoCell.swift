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
        imageView.layer.cornerRadius = 55 / 2
        imageView.backgroundColor = .green
        return imageView
    }()
    
    let seporatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let titleLabel: UILabel = {
        let tl = UILabel()
        tl.backgroundColor = .purple
        return tl
    }()
    
    let subtitleTextView: UITextView = {
        let st = UITextView()
        st.backgroundColor = .red
        return st
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
        addSubview(titleLabel)
        addSubview(subtitleTextView)
    }
    
    private func setupLayout() {
        thumbnailImageView.snp.makeConstraints { (make) in
            make.topMargin.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-70)
        }
        
        userProfileImageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 55, height: 55))
            make.left.equalTo(thumbnailImageView)
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(5)
        }
        
        seporatorView.snp.makeConstraints { (make) in
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.height.equalTo(1)
            make.bottom.equalTo(snp.bottom)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(userProfileImageView.snp.right).offset(5)
            make.top.equalTo(userProfileImageView)
            make.height.equalTo(25)
            make.right.equalTo(thumbnailImageView)
        }
        
        subtitleTextView.snp.makeConstraints { (make) in
            make.left.height.right.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
    }
    
}
