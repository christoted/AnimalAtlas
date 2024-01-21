//
//  AnimalFavoriteViewCell.swift
//  AnimalAtlas
//
//  Created by Christopher Minarto  on 18/01/24.
//

import UIKit
import Kingfisher

class AnimalFavoriteViewCell: UICollectionViewCell {
    
    private var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.dropShadow()
        view.backgroundColor = .white
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
    
    private var indicatorLoadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        indicatorLoadingView.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        imageView.kf.cancelDownloadTask()
        indicatorLoadingView.startAnimating()
    }
    
    private func setupView() {
        self.contentView.addSubview(containerView)
        self.containerView.addSubview(imageView)
        self.containerView.addSubview(animalName)
        self.containerView.addSubview(indicatorLoadingView)
        
        containerView.snp.makeConstraints { make in
            make.top.left.equalTo(8)
            make.right.bottom.equalTo(-8)
        }
        imageView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        animalName.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.centerX.equalTo(imageView)
        }
        indicatorLoadingView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    func setupData(animalModel: AnimalAtlasModel) {
        imageView.kf.setImage(with: URL(string: animalModel.animalImage), placeholder: UIImage(named: ""), options: [.backgroundDecode, .cacheOriginalImage]) {
            [weak self] result in
            switch result {
            case .success(_):
                self?.indicatorLoadingView.stopAnimating()
                self?.indicatorLoadingView.hidesWhenStopped = true
            case .failure(_):
                break
            }
        }
        animalName.text = animalModel.animalName
    }
}
