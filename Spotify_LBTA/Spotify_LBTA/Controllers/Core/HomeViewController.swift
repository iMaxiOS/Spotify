//
//  ViewController.swift
//  Spotify_LBTA
//
//  Created by Maxim Granchenko on 05.08.2021.
//

import UIKit

enum BrowseSectionType {
    case newReleases(viewModels: [NewReleasesCellViewModel])
    case featuredPlaylists(viewModels: [FeaturedPlaylistCellViewModel])
    case recommendedTracks(viewModels: [RecommendedTrackCellViewModel])
}

class HomeViewController: UIViewController {
    
    private var sections = [BrowseSectionType]()
    
    private var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
        return HomeViewController.createSectionLayout(section: sectionIndex)
    })
    
    private let activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.tintColor = .green
        spinner.hidesWhenStopped = true
        return spinner
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupActivity()
        setupCollectionView()
        setupSettings()
        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
        activityIndicator.center = view.center
    }
}

//MARK: - Ext View
extension HomeViewController {
    
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupActivity() {
        view.addSubview(activityIndicator)
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(NewReleaseCollectionViewCell.self,
                                forCellWithReuseIdentifier: NewReleaseCollectionViewCell.identifier)
        collectionView.register(FeaturedPlaylistCollectionViewCell.self,
                                forCellWithReuseIdentifier: FeaturedPlaylistCollectionViewCell.identifier)
        collectionView.register(RecommendedTrackCollectionViewCell.self,
                                forCellWithReuseIdentifier: RecommendedTrackCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
        switch section {
        case 0:
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let size = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.9),
                heightDimension: .absolute(360)
            )
            
            let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: size, subitem: item, count: 3)
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: verticalGroup, count: 1)
            
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            
            return section
        case 1:
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(200),
                    heightDimension: .absolute(400)
                )
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)
            
            let size = NSCollectionLayoutSize(
                widthDimension: .absolute(200),
                heightDimension: .absolute(400)
            )
            
            let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: size, subitem: item, count: 2)
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: verticalGroup, count: 1)
            
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .continuous
            
            return section
        case 2:
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0)
            
            let size = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(80)
            )
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 1)
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        default:
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let size = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.9),
                heightDimension: .absolute(360)
            )
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 1)
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        }
    }
    
    private func fetchData() {
        let group = DispatchGroup()
        
        group.enter()
        group.enter()
        group.enter()
        
        var newReleases: NewReleasesResponse?
        var featuredPlaylist: FeaturedPlaylistResponse?
        var recommendations: RecommendationResponse?
        
        APICaller.shared.getNewReleases { result in
            defer {
                group.leave()
            }
            
            switch result {
            case .success(let model):
                newReleases = model
            case .failure(let error):
                print("🍎🍎🍎\(error.localizedDescription)")
            }
        }
        
        APICaller.shared.getFeaturedPlaylist { result in
            defer {
                group.leave()
            }
            
            switch result {
            case .success(let model):
                featuredPlaylist = model
            case .failure(let error):
                print("🍎🍎🍎\(error.localizedDescription)")
            }
        }
        
        APICaller.shared.getRecommendationsGenres { result in
            switch result {
            case .success(let model):
                let genre = model.genres
                var seeds = Set<String>()

                while seeds.count < 5 {
                    if let random = genre.randomElement() {
                        seeds.insert(random)
                    }
                }
                
                APICaller.shared.getRecommendations(genres: seeds) { recommendedResult in
                    defer {
                        group.leave()
                    }
                    
                    switch recommendedResult {
                    case .success(let model):
                        recommendations = model
                    case .failure(let error):
                        print("🍎🍎🍎\(error.localizedDescription)")
                    }
                }

            case .failure(let error):
                print("🍎🍎🍎\(error)")
            }
        }
        
        group.notify(queue: .main) {
            guard let releases = newReleases?.albums.items,
                  let playlist = featuredPlaylist?.playlists.items,
                  let tracks = recommendations?.tracks
            else { return }
            
            self.configureModels(newAlbums: releases, playlist: playlist, tracks: tracks)
        }
    }
    
    private func configureModels(newAlbums: [Album], playlist: [Playlist], tracks: [AudioTrack]) {
        sections.append(.newReleases(viewModels: newAlbums.compactMap {
            return NewReleasesCellViewModel(
                name: $0.name,
                artworkURL: URL(string: $0.images.first?.url ?? ""),
                numberOfTracks: $0.total_tracks,
                artistName: $0.artists.first?.name ?? "-"
            )
        }))
        
        sections.append(.featuredPlaylists(viewModels: playlist.compactMap {
            return FeaturedPlaylistCellViewModel(
                artworkURL: URL(string: $0.images.first?.url ?? "-"),
                creatorName: $0.owner.display_name
            )
        }))
        
        sections.append(.recommendedTracks(viewModels: tracks.compactMap {
            return RecommendedTrackCellViewModel(
                name: $0.name,
                artistName: $0.artists.first?.name ?? "",
                artworkURL: URL(string: $0.album.images.first?.url ?? "-")
            )
        }))
        
        collectionView.reloadData()
    }
    
    private func setupSettings() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gear"),
            style: .done,
            target: self,
            action: #selector(didTapSettings)
        )
    }
    
    @objc private func didTapSettings() {
        let profileVC = SettingsViewController()
        profileVC.title = "Settings"
        profileVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(profileVC, animated: true)
    }
}

//MARK: - Delegate
extension HomeViewController: UICollectionViewDelegate {
    
}

//MARK: - DataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = sections[section]
        switch type {
        case .newReleases(let viewModels):
            return viewModels.count
        case .featuredPlaylists(let viewModels):
            return viewModels.count
        case .recommendedTracks(let viewModels):
            return viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let type = sections[indexPath.section]
        
        switch type {
        case .newReleases(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: NewReleaseCollectionViewCell.identifier,
                for: indexPath
            ) as? NewReleaseCollectionViewCell else {
                return UICollectionViewCell()
            }

            let viewModel = viewModels[indexPath.row]
            cell.configureCell(with: viewModel)
            
            return cell
        case .featuredPlaylists(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FeaturedPlaylistCollectionViewCell.identifier,
                for: indexPath
            ) as? FeaturedPlaylistCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(with: viewModels[indexPath.row])
            
            return cell
        case .recommendedTracks(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RecommendedTrackCollectionViewCell.identifier,
                for: indexPath
            ) as? RecommendedTrackCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(with: viewModels[indexPath.row])
            
            return cell
        }
    }
}
