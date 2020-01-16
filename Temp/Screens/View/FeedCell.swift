//
//  FeedCell.swift
//  Temp
//
//  Created by Egor Syrtcov on 1/4/20.
//  Copyright © 2020 Egor Syrtcov. All rights reserved.
//

import UIKit

private struct Properties {
    static let сellReuseIdentifier = "CellId"
}

class FeedCell: BaseCell {
    
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
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(VideoCell.self, forCellWithReuseIdentifier: Properties.сellReuseIdentifier)
        collection.dataSource = self
        collection.backgroundColor = .white
        collection.delegate = self
        return collection
    }()
    
    override func setupView() {
        super.setupView()
        
        assemble()
        backgroundColor = .darkGray
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

extension FeedCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Properties.сellReuseIdentifier, for: indexPath) as! VideoCell
        let video = videos[indexPath.item]
        cell.video = video
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (frame.width - 16 - 16) * 9 / 16
        return CGSize(width: frame.width, height: height + 16 + 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoLauncer = VideoLauncer()
        videoLauncer.showVideoPlayer()
    }
}
