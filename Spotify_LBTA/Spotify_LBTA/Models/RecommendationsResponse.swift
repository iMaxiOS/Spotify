//
//  RecommendationsResponse.swift
//  Spotify_LBTA
//
//  Created by Maxim Granchenko on 16.08.2021.
//

import Foundation

struct RecommendationResponse: Codable {
    let tracks: [AudioTrack]
}
