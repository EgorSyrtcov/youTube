//
//  MenuCell.swift
//  Temp
//
//  Created by Egor Syrtcov on 12/9/19.
//  Copyright © 2019 Egor Syrtcov. All rights reserved.
//

import UIKit

class MenuCell: BaseCell {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .white
        return imageView
    }()
    
    override func setupView() {
        super.setupView()
        
        backgroundColor = UIColor.mainPink()
        assemble()
    }
    
    override var isHighlighted: Bool {
        didSet {
            imageView.tintColor = isHighlighted ? .black : .white
        }
    }
    
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? .black : .white
        }
    }
    
    private func assemble() {
        addSubview(imageView)
        setupLay()
    }
    
    private func setupLay() {
        imageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
    }
    
            
}
