//
//  RecommendationTracksRequest.swift
//  Spotify_LBTA
//
//  Created by Maxim Granchenko on 09.08.2021.
//

import Foundation

struct RecommendationTracksResponse: Codable {
    let tracks: [Tracks]
}

struct Tracks: Codable {
    let artists: [Artists]
    let disc_number: Int
    let duration_ms: Int
    let explicit: Bool
    let external_urls: [String: String]
    let id: String
    let is_playable: Bool
    let name: String
    let preview_url: String
    let track_number: Int
    let type: String
}


