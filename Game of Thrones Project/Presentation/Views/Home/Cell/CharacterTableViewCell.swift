//
//  CharacterViewCell.swift
//  Game of Thrones Project
//
//  Created by Andy Heredia on 5/4/25.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    
    static let identifer = String(describing: CharacterTableViewCell.self)
    
    public let posterUIImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    public let titleCharacter: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let lastNameText: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleCharacter, lastNameText])
        stack.axis = .vertical
        stack.spacing = 4
        stack.layer.borderColor = UIColor.label.cgColor
        stack.layer.borderWidth = 1
        stack.layer.cornerRadius = 8
        stack.layer.masksToBounds = true
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(posterUIImageView)
        contentView.addSubview(labelStackView)
        
        applyConstraints()
    }
    
    func applyConstraints() {
        let posterUIImageViewConstraints = [
            posterUIImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            posterUIImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            posterUIImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            posterUIImageView.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let labelStackConstraints = [
            labelStackView.leadingAnchor.constraint(equalTo: posterUIImageView.trailingAnchor, constant: 20),
            labelStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(posterUIImageViewConstraints + labelStackConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    
}
