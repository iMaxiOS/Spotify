//
//  AlbumViewController.swift
//  Spotify_LBTA
//
//  Created by Maxim Granchenko on 01.09.2021.
//

import UIKit

class AlbumViewController: UIViewController {
    
    private let album: Album
    
    init(album: Album) {
        self.album = album
        
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

extension AlbumViewController {
    private func setupView() {
        title = album.name
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .systemBackground
    }
    
    private func fetchData() {
        APICaller.shared.getAlbumDetail(for: album) { result in
            switch result {
            case .success(let model): break
            case .failure(let error): break
            }
        }
    }
}
