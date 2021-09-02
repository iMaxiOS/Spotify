//
//  PlaylistHeaderCollectionReusableView.swift
//  Spotify_LBTA
//
//  Created by Maxim Granchenko on 01.09.2021.
//

import UIKit
import SDWebImage

protocol PlaylistHeaderCollectionReusableViewDelegate: AnyObject {
    func playlistHeaderCollectionReusableViewDidTapPlayAll(_ header: PlaylistHeaderCollectionReusableView)
}

class PlaylistHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "PlaylistHeaderCollectionReusableView"
    
    weak var delegate: PlaylistHeaderCollectionReusableViewDelegate?
    
    private let headerImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "photo")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()

    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 2
        return label
    }()
    
    private let ownerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .gray
        return label
    }()
    
    private let hStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 5
        stack.axis = .horizontal
        stack.alignment = .bottom
        return stack
    }()
    
    private let vStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()
    
    private let playAllButton: UIButton = {
        let button = UIButton()
        let image = UIImage(
            systemName: "play.fill",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
        )
        button.setImage(image, for: .normal)
        button.backgroundColor = .systemGreen
        button.tintColor = .label
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(handlePlayAll), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(headerImageView)
        addSubview(vStackView)
        
        vStackView.addArrangedSubview(nameLabel)
        vStackView.addArrangedSubview(descriptionLabel)
        vStackView.addArrangedSubview(hStackView)
        
        hStackView.addArrangedSubview(ownerLabel)
        hStackView.addArrangedSubview(playAllButton)
        
        setupHeaderImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

//MARK: - Extension
extension PlaylistHeaderCollectionReusableView {
    private func setupHeaderImageView() {
        NSLayoutConstraint.activate([
            headerImageView.topAnchor.constraint(equalTo: self.topAnchor),
            headerImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            headerImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6),
            headerImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6),
            
            playAllButton.heightAnchor.constraint(equalToConstant: 60),
            playAllButton.widthAnchor.constraint(equalToConstant: 60),
            
            vStackView.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 5),
            vStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            vStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            vStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ])
    }
    
    public func configure(with model: PlaylistHeaderViewModel) {
        nameLabel.text = model.name
        descriptionLabel.text = "Release Date: \(model.description)"
        ownerLabel.text = model.ownerName
        headerImageView.sd_setImage(with: model.artworkURL)
    }
    
    @objc private func handlePlayAll() {
        self.delegate?.playlistHeaderCollectionReusableViewDidTapPlayAll(self)
    }
}
