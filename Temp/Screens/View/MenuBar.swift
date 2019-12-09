//
//  MenuBar.swift
//  Temp
//
//  Created by Egor Syrtcov on 12/9/19.
//  Copyright © 2019 Egor Syrtcov. All rights reserved.
//

import UIKit

private struct Properties {
    static let сellReuseIdentifier = "CellId"
}

class MenuBar: UIView {
    
    let imageArr = ["account", "home", "trending", "subscription"]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.register(MenuCell.self, forCellWithReuseIdentifier: Properties.сellReuseIdentifier)
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        assemble()
        selectIndexPath()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func selectIndexPath() {
        let selectIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectIndexPath, animated: false, scrollPosition: .right)
    }
    
    private func assemble() {
        addSubview(collectionView)
        
        setupLayout()
    }
    
    private func setupLayout() {
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension MenuBar: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Properties.сellReuseIdentifier, for: indexPath) as! MenuCell
        cell.imageView.image = UIImage(named: imageArr[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 4, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
