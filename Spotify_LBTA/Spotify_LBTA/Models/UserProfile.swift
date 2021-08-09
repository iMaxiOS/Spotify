//
//  UserProfile.swift
//  Spotify_LBTA
//
//  Created by Maxim Granchenko on 05.08.2021.
//

import Foundation

/*
//{
//    country = UA;
//    "display_name" = iMakca;
//    "explicit_content" =     {
//        "filter_enabled" = 0;
//        "filter_locked" = 0;
//    };
//    "external_urls" =     {
//        spotify = "https://open.spotify.com/user/w4lc9ptxlxghzq638ha1chtdc";
//    };
//    followers =     {
//        href = "<null>";
//        total = 0;
//    };
//    href = "https://api.spotify.com/v1/users/w4lc9ptxlxghzq638ha1chtdc";
//    id = w4lc9ptxlxghzq638ha1chtdc;
//    images =     (
//    );
//    product = open;
//    type = user;
//    uri = "spotify:user:w4lc9ptxlxghzq638ha1chtdc";
//}
 */


struct UserProfile: Codable {
    let country: String
//    let email: String
    let id: String
    let product: String
    let images: [APIImage]
    let displayName: String
    let explicitContent: [String: Bool]
    let externalUrls: [String: String]
    
    enum CodingKeys: String, CodingKey {
        case country, id, product, images
        case displayName = "display_name"
        case explicitContent = "explicit_content"
        case externalUrls = "external_urls"
    }
}
