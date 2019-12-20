//
//  Setting.swift
//  Temp
//
//  Created by Egor Syrtcov on 12/18/19.
//  Copyright © 2019 Egor Syrtcov. All rights reserved.
//

import UIKit

class Setting: NSObject {
    let name: SettingName
    let imageName: String

    init(name: SettingName, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}
