//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Alejandro Trejo on 11/08/21.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let cache = NewtworkManager.shared.cache
    let placeHolderImage = Images.placeholder
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeHolderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
}
