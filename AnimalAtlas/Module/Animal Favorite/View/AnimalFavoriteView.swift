//
//  AnimalFavoriteView.swift
//  AnimalAtlas
//
//  Created by Christopher Minarto  on 18/01/24.
//

import UIKit
import RxSwift

class AnimalFavoriteView: UIView {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 5
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.register(AnimalFavoriteViewCell.self, forCellWithReuseIdentifier: AnimalFavoriteViewCell.className())

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInsetAdjustmentBehavior = .never
        
        return collectionView
    }()
    
    private var viewModel: AnimalFavoriteViewModel?
    private let disposeBag = DisposeBag()
    private var animalModels: [AnimalAtlasModel] = []
    
    init(viewModel: AnimalFavoriteViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupView()
        setupRx()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.left.right.equalTo(self)
        }
    }
    
    // Local
    func getFavoritePhoto() {
        viewModel?.getAnimalPhotoLiked()
    }
    
    func setupRx() {
        viewModel?.animalPhotoLocaleSubjectDriver.drive(onNext: { [weak self] data in
            self?.animalModels = data
            self?.collectionView.reloadData()
        }).disposed(by: disposeBag)
    }
}

extension AnimalFavoriteView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animalModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnimalFavoriteViewCell.className(), for: indexPath) as? AnimalFavoriteViewCell else { return UICollectionViewCell() }
        cell.setupData(animalModel: animalModels[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          // Adjust the size of each item based on your requirements
        return CGSize(width: collectionView.bounds.width / 2.1, height: collectionView.bounds.width / 2.1)
      }
}
