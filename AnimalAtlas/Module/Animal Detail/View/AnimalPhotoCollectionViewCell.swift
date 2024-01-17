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
        view.backgroundColor = .red
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
    
    var onButtonLikedTapped: ((Bool) ->())?
    var isSelectedButton = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
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
    }
    
    private func setupView() {
        self.contentView.addSubview(containerView)
        self.containerView.addSubview(imageView)
        self.containerView.addSubview(likeBtn)
        
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
    }
    
    @objc private func toggleBtnLike() {
        isSelectedButton = !isSelectedButton
        onButtonLikedTapped?(isSelectedButton)
        
        if isSelectedButton {
            likeBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeBtn.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    func setAnimaPhoto(data: Photo) {
        imageView.kf.setImage(with: URL(string: data.src.original), placeholder: UIImage(named: ""), options: [.backgroundDecode, .cacheOriginalImage])
    }
}
