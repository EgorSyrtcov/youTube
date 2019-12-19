//
//  BaseCell.swift
//  Temp
//
//  Created by Egor Syrtcov on 12/9/19.
//  Copyright © 2019 Egor Syrtcov. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
    }
    
}


