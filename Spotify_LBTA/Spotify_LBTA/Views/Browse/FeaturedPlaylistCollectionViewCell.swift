//
//  FeaturedPlaylistCollectionViewCell.swift
//  Spotify_LBTA
//
//  Created by Maxim Granchenko on 16.08.2021.
//

import UIKit

class FeaturedPlaylistCollectionViewCell: UICollectionViewCell {
    static let identifier = "FeaturedPlaylistCollectionViewCell"
    
    private let playlistCoverImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "photo")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 5
        return image
    }()
    
    private let creatorNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 10, weight: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.addSubview(playlistCoverImageView)
        
        playlistCoverImageView.addSubview(creatorNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            playlistCoverImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            playlistCoverImageView.widthAnchor.constraint(equalTo: playlistCoverImageView.heightAnchor),

            creatorNameLabel.topAnchor.constraint(equalTo: playlistCoverImageView.topAnchor, constant: 6),
            creatorNameLabel.leadingAnchor.constraint(equalTo: playlistCoverImageView.leadingAnchor, constant: 27)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        creatorNameLabel.text = nil
        playlistCoverImageView.image = nil
    }
    
    func configureCell(with viewModel: FeaturedPlaylistCellViewModel) {
        creatorNameLabel.text = viewModel.creatorName
        playlistCoverImageView.sd_setImage(with: viewModel.artworkURL)
    }
}
