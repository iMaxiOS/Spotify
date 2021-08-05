//
//  WelcomeViewController.swift
//  Spotify_LBTA
//
//  Created by Maxim Granchenko on 05.08.2021.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Sign in with Spotify", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signInButton.frame = CGRect(
            x: 20,
            y: view.height-50-view.safeAreaInsets.bottom,
            width: view.width-40,
            height: 50
        )
    }
    
    private func setupView() {
        title = "Spotify"
        
        view.backgroundColor = .systemGreen
        view.addSubview(signInButton)
        
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        signInButton.layer.cornerRadius = 20
        signInButton.clipsToBounds = true
    }
    
    private func handleSuccess(success: Bool) {
        #warning("handle Success Log In")
    }
    
    @objc func didTapSignIn() {
        let vc = AuthViewController()
        vc.completionHandler = { [weak self] success in
            DispatchQueue.main.async {
                self?.handleSuccess(success: success)
            }
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}
