//
//  ViewController.swift
//  Spotify_LBTA
//
//  Created by Maxim Granchenko on 05.08.2021.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSettings()
        fetchData()
    }
}

//MARK: - Ext View
extension HomeViewController {
    
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    private func fetchData() {
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
                
                APICaller.shared.getRecommendations(genres: seeds) { _ in

                }

            case .failure(let error):
                print("🍎🍎🍎\(error)")
            }
        }
        
        
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

