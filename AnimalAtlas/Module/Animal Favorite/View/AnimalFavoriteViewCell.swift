//
//  AnimalFavoriteViewCell.swift
//  AnimalAtlas
//
//  Created by Christopher Minarto  on 18/01/24.
//

import UIKit

class AnimalFavoriteViewCell: UICollectionViewCell {
    
    private var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.dropShadow()
        return view
    }()
    
    private var imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "cheetah.jpeg")
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    private var animalName: UILabel = {
        let view = UILabel()
        view.text = "Cheetah"
        view.font = .body1
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.contentView.addSubview(containerView)
        self.containerView.addSubview(imageView)
        self.containerView.addSubview(animalName)
        
        containerView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        imageView.snp.makeConstraints { make in
            make.top.left.equalTo(8)
            make.right.bottom.equalTo(-8)
        }
        animalName.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.centerX.equalTo(imageView)
        }
    }
}
