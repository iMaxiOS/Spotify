//
//  AuthManager.swift
//  Spotify_LBTA
//
//  Created by Maxim Granchenko on 05.08.2021.
//

import Foundation

final class AuthManager {
    
    static var shared = AuthManager()
    
    struct Constants {
        static let clientID = "63148c8b904c4619b91a7ded7dad137b"
        static let clientSecret = "ad47b4389a004feabd6a5954d711894e"
    }
    
    private init() {}
    
    public var signInURL: URL? {
        let baseURL = "https://accounts.spotify.com/authorize"
        let scopes = "user-read-private"
        let redirectURI = "https://www.instagram.com/m.granchenko/"
        let stringURL = "\(baseURL)?response_type=code&client_id=\(Constants.clientID)&scope=\(scopes)&redirect_uri=\(redirectURI)"
        return URL(string: stringURL)
    }
    
    var isSignedIn: Bool {
        return false
    }
    
    private var accessToken: String? {
        return nil
    }
    
    private var refreshToken: String? {
        return nil
    }
    
    private var tokenExpirationDate: Date? {
        return nil
    }
    
    private var shouldRefreshToken: Bool? {
        return false
    }
    
    public func exchangeCodeForToken(code: String, completion: @escaping ((Bool) -> Void)) {
        
    }
    
    public func refreshAccessToken() {
        
    }
    
    private func cacheToken() {
        
    }
}
