//
//  APICaller.swift
//  Spotify_LBTA
//
//  Created by Maxim Granchenko on 05.08.2021.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    enum HTTPMethod: String {
        case GET
        case POST
    }
    
    struct Constants {
        static let baseAPIURL = "https://api.spotify.com/v1"
    }
    
    enum APIError: Error {
        case failedToGetData
    }
    
    private init() {}
    
    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/me"), type: .GET) { baseRequest in
            URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    completion(.success(result))
                } catch {
                    print("🍎🍎🍎\(error.localizedDescription)")
                }
                
            }.resume()
        }
    }
    
    public func getNewReleases(completion: @escaping ((Result<NewReleasesResponse, Error>)) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/new-releases?limit=20"), type: .GET) { request in
            URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                    print("🍎🍎🍎\(error.localizedDescription)")
                }
                
            }.resume()
        }
    }
    
    public func getFeaturedPlaylist(completion: @escaping ((Result<FeaturedPlaylistResponse, Error>)) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/featured-playlists?limit=20"), type: .GET) { request in
            URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(FeaturedPlaylistResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                    print("🍎🍎🍎\(error.localizedDescription)")
                }
                
            }.resume()
        }
    }
    
    public func getRecommendations(genres: Set<String>, completion: @escaping ((Result<RecommendationResponse, Error>)) -> Void) {
        let seeds = genres.joined(separator: ",")
        createRequest(with: URL(string: Constants.baseAPIURL + "/recommendations?limit=40&seed_genres=\(seeds)"), type: .GET) { request in
            URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(RecommendationResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                    print("🍎🍎🍎\(error.localizedDescription)")
                }
                
            }.resume()
        }
    }
    
    public func getRecommendationsGenres(completion: @escaping ((Result<GenresResponse, Error>)) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/recommendations/available-genre-seeds"), type: .GET) { request in
            URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(GenresResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                    print("🍎🍎🍎\(error.localizedDescription)")
                }
                
            }.resume()
        }
    }
    
    private func createRequest(with url: URL?, type: HTTPMethod, completion: @escaping (URLRequest) -> Void) {
        AuthManager.shared.withValidToken { token in
            guard let urlString = url else { return }
            var request = URLRequest(url: urlString)
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            completion(request)
        }
    }
}
