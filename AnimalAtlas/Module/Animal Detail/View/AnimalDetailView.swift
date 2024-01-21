//
//  AnimalDetailView.swift
//  AnimalAtlas
//
//  Created by Christopher Minarto  on 17/01/24.
//

import UIKit
import RxSwift

class AnimalDetailView: UIView {
    
    // MARK: UI Components
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let animalNameLbl: UILabel = {
        let label = UILabel()
        label.font = .heading1
        return label
    }()
    
    private let animalSloganLbl: UILabel = {
        let label = UILabel()
        label.font = .body1
        return label
    }()
    
    private let taxonomyNameLbl: UILabel = {
        let label = UILabel() 
        label.font = .heading
        label.textColor = AnimalAtlasColor.textPrimary.color
        return label
    }()
    
    private let kingdomLbl: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = AnimalAtlasColor.textPrimary.color
        return label
    }()
    
    private let phylumLbl: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = AnimalAtlasColor.textPrimary.color
        return label
    }()
    
    private let classLbl: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = AnimalAtlasColor.textPrimary.color
        return label
    }()
    
    private let orderLbl: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = AnimalAtlasColor.textPrimary.color
        return label
    }()
    
    private let locationTitleLbl: UILabel = {
        let label = UILabel()
        label.font = .heading
        label.textColor = AnimalAtlasColor.textPrimary.color
        return label
    }()
    
    private let locationLbl: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = AnimalAtlasColor.textPrimary.color
        return label
    }()
    
    private let characteristicsTitleLbl: UILabel = {
        let label = UILabel()
        label.font = .heading
        label.textColor = AnimalAtlasColor.textPrimary.color
        return label
    }()
    
    private let preyLbl: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = AnimalAtlasColor.textPrimary.color
        return label
    }()
    
    private let habitatLbl: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = AnimalAtlasColor.textPrimary.color
        return label
    }()
    
    private let topSpeedLbl: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = AnimalAtlasColor.textPrimary.color
        return label
    }()
    
    private let lifespanLbl: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = AnimalAtlasColor.textPrimary.color
        return label
    }()
    
    private let photosLbl: UILabel = {
        let label = UILabel()
        label.font = .heading
        label.textColor = AnimalAtlasColor.textPrimary.color
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.register(AnimalPhotoCollectionViewCell.self, forCellWithReuseIdentifier: AnimalPhotoCollectionViewCell.className())
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    private var indicatorLoadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        return view
    }()
    
    // MARK: Var
    
    var animalName: String = "" {
        didSet {
            viewModel?.getCombineAnimalData(animalName: animalName)
        }
    }
    var animalLocations: String = ""
    var viewModel: AnimalDetailViewModel?
    let disposeBag = DisposeBag()
    private var animalPhotos: [Photo] = []
    
    init(viewModel: AnimalDetailViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        setupView()
        getAnimalData()
        getAnimalPhoto()
        indicatorLoadingView.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(scrollView)
        self.scrollView.addSubview(containerView)
        self.containerView.addSubview(animalNameLbl)
        self.containerView.addSubview(animalSloganLbl)
        self.containerView.addSubview(taxonomyNameLbl)
        self.containerView.addSubview(kingdomLbl)
        self.containerView.addSubview(phylumLbl)
        self.containerView.addSubview(classLbl)
        self.containerView.addSubview(orderLbl)
        self.containerView.addSubview(locationTitleLbl)
        self.containerView.addSubview(locationLbl)
        self.containerView.addSubview(characteristicsTitleLbl)
        self.containerView.addSubview(preyLbl)
        self.containerView.addSubview(habitatLbl)
        self.containerView.addSubview(topSpeedLbl)
        self.containerView.addSubview(lifespanLbl)
        self.containerView.addSubview(photosLbl)
        self.containerView.addSubview(collectionView)
        self.containerView.addSubview(indicatorLoadingView)
        
        scrollView.snp.makeConstraints { make in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
        
        containerView.snp.makeConstraints { make in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
        animalNameLbl.snp.makeConstraints { make in
            make.left.top.equalTo(16)
        }
        animalSloganLbl.snp.makeConstraints { make in
            make.top.equalTo(animalNameLbl.snp.bottom).offset(8)
            make.left.equalTo(16)
        }
        taxonomyNameLbl.snp.makeConstraints { make in
            make.top.equalTo(animalSloganLbl.snp.bottom).offset(16)
            make.left.equalTo(16)
        }
        kingdomLbl.snp.makeConstraints { make in
            make.top.equalTo(taxonomyNameLbl.snp.bottom).offset(8)
            make.left.equalTo(16)
        }
        phylumLbl.snp.makeConstraints { make in
            make.top.equalTo(kingdomLbl.snp.bottom).offset(8)
            make.left.equalTo(16)
        }
        classLbl.snp.makeConstraints { make in
            make.top.equalTo(phylumLbl.snp.bottom).offset(8)
            make.left.equalTo(16)
        }
        orderLbl.snp.makeConstraints { make in
            make.top.equalTo(classLbl.snp.bottom).offset(8)
            make.left.equalTo(16)
        }
        locationTitleLbl.snp.makeConstraints { make in
            make.top.equalTo(orderLbl.snp.bottom).offset(16)
            make.left.equalTo(16)
        }
        locationLbl.snp.makeConstraints { make in
            make.top.equalTo(locationTitleLbl.snp.bottom).offset(8)
            make.left.equalTo(16)
        }
        characteristicsTitleLbl.snp.makeConstraints { make in
            make.top.equalTo(locationLbl.snp.bottom).offset(16)
            make.left.equalTo(16)
        }
        preyLbl.snp.makeConstraints { make in
            make.top.equalTo(characteristicsTitleLbl.snp.bottom).offset(8)
            make.left.equalTo(16)
        }
        habitatLbl.snp.makeConstraints { make in
            make.top.equalTo(preyLbl.snp.bottom).offset(8)
            make.left.equalTo(16)
        }
        topSpeedLbl.snp.makeConstraints { make in
            make.top.equalTo(habitatLbl.snp.bottom).offset(8)
            make.left.equalTo(16)
        }
        lifespanLbl.snp.makeConstraints { make in
            make.top.equalTo(topSpeedLbl.snp.bottom).offset(8)
            make.left.equalTo(16)
        }
        photosLbl.snp.makeConstraints { make in
            make.top.equalTo(lifespanLbl.snp.bottom).offset(16)
            make.left.equalTo(16)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(photosLbl.snp.bottom).offset(0)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
        indicatorLoadingView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    private func getAnimalData() {
        viewModel?.animalDetailSubjectDriver.drive(onNext: { [weak self] animalData in
            self?.indicatorLoadingView.stopAnimating()
            self?.indicatorLoadingView.hidesWhenStopped = true
            self?.animalNameLbl.text = animalData.name
            self?.animalSloganLbl.text = animalData.characteristics.slogan ?? ""
            self?.taxonomyNameLbl.text = "Taxonomy"
            self?.kingdomLbl.text = "Kingdom :  \(animalData.taxonomy.kingdom ?? "")"
            self?.phylumLbl.text = "Pyhlum : \(animalData.taxonomy.phylum ?? "")"
            self?.classLbl.text = "Class : \(animalData.taxonomy.taxonomyClass ?? "")"
            self?.orderLbl.text = "Order : \(animalData.taxonomy.order ?? "")"
            self?.locationTitleLbl.text = "Location"
            self?.locationLbl.text = Converter.shared.convertArrayToString(arrayOfString: animalData.locations)
            self?.characteristicsTitleLbl.text = "Characteristics"
            self?.preyLbl.text = "Prey : \(animalData.characteristics.prey ?? "-")"
            self?.habitatLbl.text = "Habitat : \(animalData.characteristics.habitat ?? "")"
            self?.topSpeedLbl.text = "Top Speed : \(animalData.characteristics.topSpeed ?? "")"
            self?.lifespanLbl.text = "Life Span : \(animalData.characteristics.lifespan ?? "")"
            self?.photosLbl.text = "Photos"
            self?.collectionView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    private func getAnimalPhoto() {
        viewModel?.animalPhotoSubjectDriver.drive(onNext: { [weak self] data in
            self?.animalPhotos = data.photos
            self?.getAnimalPhotoLiked()
            self?.collectionView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    // Locale
    private func getAnimalPhotoLiked() {
        viewModel?.getAnimalPhotoLiked()
        viewModel?.animalPhotoLocaleSubjectDriver.drive(onNext: { [weak self] animalModels in
            guard let self = self else { return }
            for (_, val) in animalModels.enumerated() {
                for (indexAnimalPhotoResponse, valAnimalPhotoResponse) in self.animalPhotos.enumerated() {
                    if (val.animalId == valAnimalPhotoResponse.id) {
                        self.animalPhotos[indexAnimalPhotoResponse].isLiked = true
                        self.collectionView.reloadData()
                    }
                }
            }
        }).disposed(by: disposeBag)
    }
    
    func fetchTheAnimalPhoto() {
        getAnimalPhoto()
    }
}

extension AnimalDetailView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animalPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnimalPhotoCollectionViewCell.className(), for: indexPath) as? AnimalPhotoCollectionViewCell else { return UICollectionViewCell() }
        
        let photo = animalPhotos[indexPath.row]
        cell.setAnimalPhoto(data: photo, animalName: self.animalNameLbl.text ?? "", animalType: self.animalName)
        cell.idx = indexPath.row
        
        cell.onButtonLikedTapped = {[weak self] animalModel,idx, isLiked in
            // Save or Delete to Local Database
            if isLiked {
                self?.viewModel?.saveAnimalPhoto(animalModel: animalModel)
                self?.animalPhotos[idx].isLiked = true
            } else {
                self?.viewModel?.deleteAnimalPhoto(animalId: animalModel.animalId)
            }
            self?.fetchTheAnimalPhoto()
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          // Adjust the size of each item based on your requirements
          return CGSize(width: 125, height: 125)
      }

}
