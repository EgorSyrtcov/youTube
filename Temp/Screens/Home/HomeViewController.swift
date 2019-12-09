//
//  ViewController.swift
//  Temp
//
//  Created by Egor Syrtcov on 09/11/2019.
//  Copyright © 2019 Egor Syrtcov. All rights reserved.
//

import UIKit
import SnapKit

private struct Properties {
    static let сellReuseIdentifier = "CellId"
}

final class HomeViewController: UIViewController {
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width, height: 310)
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.alwaysBounceVertical = true
        collection.backgroundColor = .clear
        collection.dataSource = self
        collection.delegate = self
        collection.register(VideoCell.self, forCellWithReuseIdentifier: Properties.сellReuseIdentifier)
        return collection
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupNavigationBar()
        assemble()
        setupLayout()
        print("Egor")
    }
    
  
    private func setupNavigationBar() {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.barStyle = .black
        
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func assemble() {
       view.addSubview(menuBar)
       view.addSubview(collectionView)

    }
    
    private func setupLayout() {
        menuBar.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.left.right.topMargin.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(menuBar.snp.bottom)
        }
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Properties.сellReuseIdentifier, for: indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    
    
    
}
