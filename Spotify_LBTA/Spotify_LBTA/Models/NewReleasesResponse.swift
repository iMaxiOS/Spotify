//
//  NewReleasesResponse.swift
//  Spotify_LBTA
//
//  Created by Maxim Granchenko on 09.08.2021.
//

import Foundation

/*

 {
     albums =     {
         href = "https://api.spotify.com/v1/browse/new-releases?offset=0&limit=20";
         items =         (
                         {
                 "album_type" = single;
                 artists =                 (
                                         {
                         "external_urls" =                         {
                             spotify = "https://open.spotify.com/artist/1Xyo4u8uXC1ZmMpatF05PJ";
                         };
                         href = "https://api.spotify.com/v1/artists/1Xyo4u8uXC1ZmMpatF05PJ";
                         id = 1Xyo4u8uXC1ZmMpatF05PJ;
                         name = "The Weeknd";
                         type = artist;
                         uri = "spotify:artist:1Xyo4u8uXC1ZmMpatF05PJ";
                     }
                 );
                 "available_markets" =                 (
                     AD,
                     AE,
                     AG,
                     AL,
                     AM,
                     AO
                 );
                 "external_urls" =                 {
                     spotify = "https://open.spotify.com/album/6DmXKM13nNgIIby2FdK0f8";
                 };
                 href = "https://api.spotify.com/v1/albums/6DmXKM13nNgIIby2FdK0f8";
                 id = 6DmXKM13nNgIIby2FdK0f8;
                 images =                 (
                                         {
                         height = 640;
                         url = "https://i.scdn.co/image/ab67616d0000b2733c041e53cb5c38b6de03e758";
                         width = 640;
                     },
                                         {
                         height = 300;
                         url = "https://i.scdn.co/image/ab67616d00001e023c041e53cb5c38b6de03e758";
                         width = 300;
                     },
                                         {
                         height = 64;
                         url = "https://i.scdn.co/image/ab67616d000048513c041e53cb5c38b6de03e758";
                         width = 64;
                     }
                 );
                 name = "Take My Breath";
                 "release_date" = "2021-08-06";
                 "release_date_precision" = day;
                 "total_tracks" = 1;
                 type = album;
                 uri = "spotify:album:6DmXKM13nNgIIby2FdK0f8";
            }
            )
     }
 }
 
*/

struct NewReleasesResponse: Codable {
    let albums: AlbumsResponse
}

struct AlbumsResponse: Codable {
    let items: [Album]
}

struct Album: Codable {
    let album_type: String
    let available_markets: [String]
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let release_date: String
    let total_tracks: Int
    let artists: [Artists]
}

