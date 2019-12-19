//
//  Setting.swift
//  Temp
//
//  Created by Egor Syrtcov on 12/18/19.
//  Copyright © 2019 Egor Syrtcov. All rights reserved.
//

import UIKit

class Setting: NSObject {
    let name: String
    let imageName: String

    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}
