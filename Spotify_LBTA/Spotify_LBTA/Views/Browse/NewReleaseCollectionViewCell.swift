//
//  NewReleaseCollectionViewCell.swift
//  Spotify_LBTA
//
//  Created by Maxim Granchenko on 16.08.2021.
//

import UIKit
import SDWebImage

class NewReleaseCollectionViewCell: UICollectionViewCell {
    static let identifier = "NewReleaseCollectionViewCell"
    
    private let albumCoverImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "photo")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 5
        return image
    }()
    
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .light)
        return label
    }()
    
    private let numberTrackLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .thin)
        return label
    }()
    
    let hStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }()
    
    let vStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.clipsToBounds = true
        contentView.addSubview(hStackView)
        
        hStackView.addArrangedSubview(albumCoverImageView)
        hStackView.addArrangedSubview(vStackView)
        vStackView.addArrangedSubview(albumNameLabel)
        vStackView.addArrangedSubview(artistNameLabel)
        vStackView.addArrangedSubview(numberTrackLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        vStackView.setCustomSpacing(10, after: artistNameLabel)
        
        NSLayoutConstraint.activate([
            albumCoverImageView.widthAnchor.constraint(equalTo: albumCoverImageView.heightAnchor),
            numberTrackLabel.heightAnchor.constraint(equalToConstant: 25),
            
            hStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            hStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            hStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            hStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        albumNameLabel.text = nil
        numberTrackLabel.text = nil
        artistNameLabel.text = nil
        albumCoverImageView.image = nil
    }
    
    func configureCell(with viewModel: NewReleasesCellViewModel) {
        albumNameLabel.text = viewModel.name
        numberTrackLabel.text = "Tracks: \(viewModel.numberOfTracks)"
        artistNameLabel.text = viewModel.artistName
        albumCoverImageView.sd_setImage(with: viewModel.artworkURL)
    }
}
