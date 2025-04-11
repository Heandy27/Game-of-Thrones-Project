//
//  DetailViewController.swift
//  Game of Thrones Project
//
//  Created by Andy Heredia on 8/4/25.
//

import UIKit

class DetailViewController: UIViewController {
    
    private let posterUIImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let informationLabel: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.font = .systemFont(ofSize: 24, weight: .bold)
        text.text = "Information"
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let fullNameLabel: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let titleText: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let familyText: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var vStack: UIStackView = {
        let vstack = UIStackView(arrangedSubviews: [informationLabel, fullNameLabel, titleText, familyText])
        vstack.spacing = 10
        vstack.axis = .vertical
        vstack.alignment = .leading
        vstack.distribution = .fill
        vstack.backgroundColor = .white
        vstack.layer.cornerRadius = 20
        vstack.layer.masksToBounds = true
        vstack.layoutMargins = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        vstack.isLayoutMarginsRelativeArrangement = true
        vstack.translatesAutoresizingMaskIntoConstraints = false
  
        return vstack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(posterUIImageView)
        view.addSubview(vStack)
        applyConstraints()
        
        
        
    }
    
    func applyConstraints() {
        let posterUIImageViewConstraints = [
            posterUIImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            posterUIImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            posterUIImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            posterUIImageView.heightAnchor.constraint(equalToConstant: 450)
        ]
        
        let vStackConstraints = [
            vStack.topAnchor.constraint(equalTo: posterUIImageView.bottomAnchor, constant: -20),
            vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
           // vStack.bottomAnchor.constraint(equalTo: view.bottomAnchor)
           
        ]
        
        NSLayoutConstraint.activate(posterUIImageViewConstraints + vStackConstraints )
        
    }
  
    func configure(with model: GOTResponse) {
        fullNameLabel.text = "Full Name: \(model.fullName)"
        titleText.text = "Title: \(model.title)"
        familyText.text = "Family: \(model.family)"
        
        guard let url = URL(string: model.imageUrl) else {return}
        
        posterUIImageView.loadImageRemote(url: url)
    }

}
