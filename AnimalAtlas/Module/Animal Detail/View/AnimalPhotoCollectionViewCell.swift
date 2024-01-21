//
//  AnimalPhotoCollectionViewCell.swift
//  AnimalAtlas
//
//  Created by Christopher Minarto  on 17/01/24.
//

import UIKit
import SnapKit
import Kingfisher

class AnimalPhotoCollectionViewCell: UICollectionViewCell {
    
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
    
    private lazy var likeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "heart"), for: .normal)
        btn.addTarget(self, action: #selector(toggleBtnLike), for: .touchUpInside)
        return btn
    }()
    
    private var indicatorLoadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        return view
    }()
    
    var onButtonLikedTapped: ((AnimalAtlasModel, Int, Bool) ->())?
    var isSelectedButton = false
    var animalAtlasModel: AnimalAtlasModel?
    var dataAnimalPhoto: Photo?
    var idx: Int = -1
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        indicatorLoadingView.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func prepareForReuse() {
        imageView.kf.cancelDownloadTask()
        indicatorLoadingView.startAnimating()
    }
    
    private func setupView() {
        self.contentView.addSubview(containerView)
        self.containerView.addSubview(imageView)
        self.containerView.addSubview(likeBtn)
        self.containerView.addSubview(indicatorLoadingView)
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.left.equalTo(8)
            make.right.bottom.equalTo(-8)
        }
        imageView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
        }
        likeBtn.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(-10) // -6
            make.right.equalTo(imageView.snp.right).offset(8) // 8
        }
        indicatorLoadingView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    @objc private func toggleBtnLike() {
        isSelectedButton = !isSelectedButton
        guard let animalAtlasModel = animalAtlasModel else { return }
        onButtonLikedTapped?(animalAtlasModel, idx, isSelectedButton)
        setupButtonState(isSelectedButton: isSelectedButton)
    }
    
    func setAnimalPhoto(data: Photo, animalName: String, animalType: String) {
        self.dataAnimalPhoto = data
        isSelectedButton = data.isLiked ?? false
        imageView.kf.setImage(with: URL(string: data.src.original), placeholder: nil, options: [.backgroundDecode, .cacheOriginalImage]) {[weak self] result in
            switch result {
            case .success(_):
                self?.indicatorLoadingView.stopAnimating()
                self?.indicatorLoadingView.hidesWhenStopped = true
            case .failure(_):
                break
            }
        }
        self.animalAtlasModel = AnimalAtlasModel(animalId: data.id, animalName: animalName, animalType: animalType, animalImage: data.src.original)
        setupButtonState(isSelectedButton: isSelectedButton)
    }
    
    private func setupButtonState(isSelectedButton: Bool) {
        if isSelectedButton {
            likeBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeBtn.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
}
