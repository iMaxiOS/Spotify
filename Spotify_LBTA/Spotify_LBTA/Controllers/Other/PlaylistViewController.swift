//
//  PlaylistViewController.swift
//  Spotify_LBTA
//
//  Created by Maxim Granchenko on 05.08.2021.
//

import UIKit

class PlaylistViewController: UIViewController {

    private let playlist: Playlist
    
    init(playlist: Playlist) {
        self.playlist = playlist
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchData()
    }
}

extension PlaylistViewController {
    private func setupView() {
        title = playlist.name
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .systemBackground
    }
    
    private func fetchData() {
        APICaller.shared.getPlaylistDetail(for: playlist) { result in
            switch result {
            case .success(let model): break
            case .failure(let error): break
            }
        }
    }
}

