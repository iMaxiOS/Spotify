//
//  SettingsModel.swift
//  Spotify_LBTA
//
//  Created by Maxim Granchenko on 06.08.2021.
//

import Foundation

struct Section {
    let title: String
    let option: [Option]
}

struct Option {
    let title: String
    let handle: () -> Void
}
