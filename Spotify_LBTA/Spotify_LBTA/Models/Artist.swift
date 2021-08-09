//
//  Artist.swift
//  Spotify_LBTA
//
//  Created by Maxim Granchenko on 05.08.2021.
//

import Foundation

struct Artists: Codable {
    let id: String
    let name: String
    let type: String
    let external_urls: [String: String]
}
