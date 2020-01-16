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
    
    let titles = ["Home", "Trending", "Subscriptions", "Account"]
    
    lazy var settingsLauncher: SettingsLauncer = {
        let settingsLauncher = SettingsLauncer()
        settingsLauncher.homeViewController = self
        return settingsLauncher
    }()
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width, height: self.view.frame.height - 100)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.isPagingEnabled = true
        collection.backgroundColor = .clear
        collection.dataSource = self
        collection.delegate = self
        collection.register(FeedCell.self, forCellWithReuseIdentifier: Properties.сellReuseIdentifier)
        return collection
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupNavigationBar()
        assemble()
        setupLayout()
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.barStyle = .blackTranslucent
        navigationController?.navigationBar.shadowImage = UIImage()

        setupNavigationButtons()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        menuBar.horizontalBarView.snp.updateConstraints { (make) in
            make.left.equalTo(scrollView.contentOffset.x / 4)
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        
        let indexPath = IndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
        
        setTitleForIndex(index: Int(index))
    }
    
    private func setTitleForIndex(index: Int) {
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = titles[Int(index)]
        }
    }
    
    private func setupNavigationButtons() {
        let searchBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "search"), style: .done, target: self, action: #selector(tabSearchNavigationBar))
        let moreBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "more"), style: .done, target: self, action: #selector(tabMoreNavigationBar))
        navigationItem.rightBarButtonItems = [moreBarButton, searchBarButton]
    }
    
    @objc func tabSearchNavigationBar() {
        scrollToMenuIndex(menuIndex: 2)
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
        
        setTitleForIndex(index: menuIndex)
    }
    
    @objc func tabMoreNavigationBar() {
        settingsLauncher.showSettings()
    }
    
    func showSettingsViewController(setting: Setting) {
        
        switch setting.name {
        case SettingName.setting:
            let settingViewController = SettingsViewController()
            settingViewController.title = setting.name.rawValue
            navigationController?.pushViewController(settingViewController, animated: true)
        default:
            let otherVC = UIViewController()
            otherVC.view.backgroundColor = .white
            otherVC.title = setting.name.rawValue
            navigationController?.pushViewController(otherVC, animated: true)
        }
    }
    
    private func assemble() {
       view.addSubview(menuBar)
       view.addSubview(collectionView)
    }
    
    private func setupLayout() {
        menuBar.snp.makeConstraints { (make) in
            
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(menuBar.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier: String
        
        switch indexPath.item {
        case 0:
            identifier = Properties.сellReuseIdentifier
        default:
            identifier = Properties.сellReuseIdentifier
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        return cell
    }
}
