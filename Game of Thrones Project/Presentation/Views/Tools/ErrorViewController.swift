//
//  ErrorViewController.swift
//  Game of Thrones Project
//
//  Created by Andy Heredia on 11/4/25.
//

import UIKit

class ErrorViewController: UIViewController {
    
    private var appState: AppState
    
    init(appState: AppState) {
        self.appState = appState
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    private let iconErrorImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "x.circle.fill")
        image.tintColor = .white
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let textError: UILabel = {
        let text = UILabel()
        text.text = "Something went wrong, Please try again."
        text.textColor = .white
        text.font = .systemFont(ofSize: 24, weight: .medium)
        text.numberOfLines = 0
        text.textAlignment = .center
        return text
    }()
    
    private let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Try Again!", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var verticalStack: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [iconErrorImageView, textError, actionButton])
        vStack.axis = .vertical
        vStack.spacing = 15
        vStack.alignment = .center
        vStack.translatesAutoresizingMaskIntoConstraints = false
        return vStack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        view.addSubview(verticalStack)
        actionButton.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
        configureContraints()
    }
    
    
   @objc func retryButtonTapped() {
       appState.status = .loading
    }
    
    
    func configureContraints() {
        let verticalStackConstraints = [
            verticalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verticalStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            verticalStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            verticalStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ]
        
        let iconErrorImageViewConstraints = [
            iconErrorImageView.widthAnchor.constraint(equalToConstant: 80),
            iconErrorImageView.heightAnchor.constraint(equalToConstant: 80)
        ]
        
        let actionButtonConstraints = [
            actionButton.widthAnchor.constraint(equalToConstant: 150),
            actionButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(verticalStackConstraints + iconErrorImageViewConstraints + actionButtonConstraints)
    }



}
