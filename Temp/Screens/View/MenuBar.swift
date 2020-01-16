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
    
    let horizontalBarView = UIView()
    var homeController: HomeViewController?
    
    let imageArr = ["account", "home", "trending", "subscription"]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(MenuCell.self, forCellWithReuseIdentifier: Properties.сellReuseIdentifier)
        collection.dataSource = self
        collection.backgroundColor = UIColor.mainPink()
        collection.delegate = self
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        assemble()
        selectIndexPath()
        setupHorizontalBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func selectIndexPath() {
        let selectIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectIndexPath, animated: false, scrollPosition: .right)
    }
    
    private func setupHorizontalBar() {
        horizontalBarView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        addSubview(horizontalBarView)
        
        horizontalBarView.snp.makeConstraints { (make) in
            make.left.bottom.equalToSuperview()
            make.width.equalTo(snp.width).multipliedBy(0.25)
            make.height.equalTo(6)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            homeController?.scrollToMenuIndex(menuIndex: indexPath.item)
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
}
