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
    
    lazy var settingsLauncher: SettingsLauncer = {
        let settingsLauncher = SettingsLauncer()
        settingsLauncher.homeViewController = self
        return settingsLauncher
    }()
    
    var videos: [Video] = {
        var kanyeChannel = Channel(name: "TaylorSwiftVevo 1,604,683,594", profileImageName: "taylor")
        var kanyeChannel2 = Channel(name: "TaylorSwiftVevo 1,963,549,594", profileImageName: "taylor2")
        var kanyeChannel3 = Channel(name: "TaylorSwiftVevo 1,831,863,594", profileImageName: "taylor3")
        var kanyeChannel4 = Channel(name: "TaylorSwiftVevo 1,207,264,594", profileImageName: "taylor4")
        
        var blankSpaceVideo = Video(thumbnailImageName: "taylor swift", title: "Taylor Swift - Blank Space", channel: kanyeChannel)
        var blankSpaceVideo2 = Video(thumbnailImageName: "taylor swift2", title: "Taylor Swift - Bad Blood feathera Bad Blood feathera", channel: kanyeChannel2)
        var blankSpaceVideo3 = Video(thumbnailImageName: "taylor swift3", title: "Taylor Swift - Blank Space", channel: kanyeChannel3)
        var blankSpaceVideo4 = Video(thumbnailImageName: "taylor swift4", title: "Taylor Swift - Blank Space", channel: kanyeChannel4)
        return [blankSpaceVideo, blankSpaceVideo2, blankSpaceVideo3, blankSpaceVideo4]
    }()
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.isPagingEnabled = true
        collection.backgroundColor = .clear
        collection.dataSource = self
        collection.delegate = self
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Properties.сellReuseIdentifier)
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

//        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
//            navigationController?.isNavigationBarHidden = true
//        } else {
//           navigationController?.isNavigationBarHidden = false
//        }
    }
    
    private func setupNavigationButtons() {
        let searchBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "search"), style: .done, target: self, action: #selector(tabSearchNavigationBar))
        let moreBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "more"), style: .done, target: self, action: #selector(tabMoreNavigationBar))
        navigationItem.rightBarButtonItems = [moreBarButton, searchBarButton]
    }
    
    @objc func tabSearchNavigationBar() {
        print("tabSearchNavigationBar")
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Properties.сellReuseIdentifier, for: indexPath)
        let colors: [UIColor] = [.blue, .green, .yellow, .red]
        cell.backgroundColor = colors[indexPath.row]
        return cell
    }
    
}

//extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return videos.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Properties.сellReuseIdentifier, for: indexPath) as! VideoCell
//        cell.video = videos[indexPath.item]
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//}
