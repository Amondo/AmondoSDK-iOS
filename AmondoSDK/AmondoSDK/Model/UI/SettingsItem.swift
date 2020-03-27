//
//  SettingsItem.swift
//  Amondo
//
//  Created by developer@amondo.com on 8/7/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation

enum SettingsItemType: String {
    case accessory
    case simple
    case switcher
}

struct SettingsItem {
    let title: String
    let type: SettingsItemType
    let value: String
}
