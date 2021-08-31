//
//  RecommendedTrackCollectionViewCell.swift
//  Spotify_LBTA
//
//  Created by Maxim Granchenko on 16.08.2021.
//

import UIKit

class RecommendedTrackCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecommendedTrackCollectionViewCell"
    
    private let recommendedCoverImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "photo")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
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
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 5
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.clipsToBounds = true
        contentView.addSubview(hStackView)
        
        hStackView.addArrangedSubview(recommendedCoverImageView)
        hStackView.addArrangedSubview(vStackView)
        vStackView.addArrangedSubview(artistNameLabel)
        vStackView.addArrangedSubview(trackNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            recommendedCoverImageView.widthAnchor.constraint(equalTo: recommendedCoverImageView.heightAnchor),
            
            hStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            hStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            hStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            hStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trackNameLabel.text = nil
        artistNameLabel.text = nil
        recommendedCoverImageView.image = nil
    }
    
    func configureCell(with viewModel: RecommendedTrackCellViewModel) {
        trackNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
        recommendedCoverImageView.sd_setImage(with: viewModel.artworkURL)
    }
}
