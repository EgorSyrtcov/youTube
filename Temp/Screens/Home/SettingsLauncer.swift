//
//  SettingsLauncer.swift
//  Temp
//
//  Created by Egor Syrtcov on 12/16/19.
//  Copyright © 2019 Egor Syrtcov. All rights reserved.
//

import UIKit

private struct Properties {
    static let сellReuseIdentifier = "CellId"
}

enum SettingName: String {
    case setting = "Setting"
    case cancel = "Cancel"
    case terms = "Terms"
    case sent = "Sent"
    case help = "Help"
    case switchAccount = "Switch Account"
}

final class SettingsLauncer: NSObject {
    
   weak var homeViewController: HomeViewController?
    
    let blackView = UIView()
    
    let cellHeight: CGFloat = 50
    
    let settings: [Setting] = {
        
        let setting = Setting(name: SettingName.setting, imageName: "setttings")
        let terms = Setting(name: SettingName.terms, imageName: "Tersm")
        let sent = Setting(name: SettingName.sent, imageName: "send")
        let help = Setting(name: SettingName.help, imageName: "help")
        let switchAccount = Setting(name: SettingName.switchAccount, imageName: "profile")
        let cancel = Setting(name: SettingName.cancel, imageName: "cancel")
        
        return [setting, terms, sent, help, switchAccount, cancel]
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .white
        collection.dataSource = self
        collection.delegate = self
        collection.register(SettingCell.self, forCellWithReuseIdentifier: Properties.сellReuseIdentifier)
        return collection
    }()
    
    func showSettings() {
        if let window = UIApplication.shared.keyWindow {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            let height: CGFloat = CGFloat(settings.count) * cellHeight
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { [weak self] in
                self?.blackView.alpha = 1
                self?.collectionView.frame = CGRect(x: 0, y: y, width: window.frame.width, height: window.frame.height)
            }, completion: nil)
        }
    }
    
    @objc func handleDismiss(setting: Setting) {

            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { [weak self] in
                self?.blackView.alpha = 0

                if let window = UIApplication.shared.keyWindow {
                    self?.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: window.frame.height)
                }

            }) { (completed: Bool) in

                if setting.name.rawValue != SettingName.cancel.rawValue {
                    self.homeViewController?.showSettingsViewController(setting: setting)
      }
    }
  }
}

extension SettingsLauncer: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Properties.сellReuseIdentifier, for: indexPath) as! SettingCell
        
        let setting = settings[indexPath.item]
        cell.setting = setting
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let settings = self.settings[indexPath.row]
        handleDismiss(setting: settings)
    }
}

