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
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
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

