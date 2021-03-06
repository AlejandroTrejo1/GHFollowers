//
//  GFItemView.swift
//  GHFollowers
//
//  Created by Alejandro Trejo on 17/08/21.
//

import UIKit

enum ItemInfoType {
    case repos, gist, followers, following
}

class GFItemView: UIView {
    
    let symbolImageView = UIImageView()
    let titleLabel =  GFTitleLabel(textAligment: .left, fontSize: 14)
    let countLabel = GFTitleLabel(textAligment: .center, fontSize: 14)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        addSubview(symbolImageView)
        addSubview(titleLabel)
        addSubview(countLabel)
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .label
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    
    func set(itemInfoType: ItemInfoType, withCount count: Int) {
        switch itemInfoType {
        case .repos:
            symbolImageView.image = SFSymbols.repos
            titleLabel.text = "Repos Publicos"
        case .gist:
            symbolImageView.image = SFSymbols.gist
            titleLabel.text = "Gist Publicos"
            
        case .followers:
            symbolImageView.image = SFSymbols.followers
            titleLabel.text = "Seguidores"
        case .following:
            symbolImageView.image = SFSymbols.following
            titleLabel.text = "Siguiendo"
        }
        countLabel.text = String(count)
    }
    
}
