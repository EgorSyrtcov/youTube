//
//  VideoCell.swift
//  Temp
//
//  Created by Egor Syrtcov on 03/12/2019.
//  Copyright © 2019 Egor Syrtcov. All rights reserved.
//

import UIKit

class VideoCell: UICollectionViewCell {
    
    var video: Video? {
        didSet {
            guard let video = video else {return}
            
            thumbnailImageView.image = UIImage(named: video.thumbnailImageName!)
            titleLabel.text = video.title
            userProfileImageView.image = UIImage(named: (video.channel?.profileImageName)!)
            subtitleTextView.text = video.channel?.name
        }
    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let seporatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let titleLabel: UILabel = {
        let tl = UILabel()
        tl.numberOfLines = 2
        tl.font = UIFont.systemFont(ofSize: 16)
        return tl
    }()
    
    let subtitleTextView: UITextView = {
        let st = UITextView()
        st.textColor = .lightGray
        st.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
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
            make.bottom.equalToSuperview().offset(-80)
        }
        
        userProfileImageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 60, height: 60))
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
            make.height.lessThanOrEqualTo(45)
            make.right.equalTo(thumbnailImageView)
        }
        
        subtitleTextView.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleLabel)
            make.height.lessThanOrEqualTo(20)
            make.top.equalTo(titleLabel.snp.bottom)
        }
    }
    
}
