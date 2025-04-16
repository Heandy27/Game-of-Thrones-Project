//
//  LoadingViewController.swift
//  Game of Thrones Project
//
//  Created by Andy Heredia on 11/4/25.
//

import UIKit

class LoadingViewController: UIViewController {
    
    private let backgroundUIImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "background")
        return image
    }()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: .medium)
        activityView.color = .white
        activityView.translatesAutoresizingMaskIntoConstraints = false
        return activityView
    }()
    
    private let loadingText: UILabel = {
        let text = UILabel()
        text.text = "Loading..."
        text.textColor = .white
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backgroundUIImageView)
        backgroundUIImageView.frame = view.bounds
        view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        view.addSubview(loadingText)
        configureConstraints()
    }
    

    
    func configureConstraints() {
        let activityIndicatorViewViewConstraints = [
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        
        let loadingTextConstraints = [
            loadingText.bottomAnchor.constraint(equalTo: activityIndicatorView.topAnchor, constant: 50),
            loadingText.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(activityIndicatorViewViewConstraints + loadingTextConstraints)
    }
    
    
}

