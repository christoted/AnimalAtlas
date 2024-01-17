//
//  AnimalListViewController.swift
//  AnimalAtlas
//
//  Created by Christopher Minarto  on 16/01/24.
//

import UIKit
import SnapKit
import RxSwift

class AnimalListViewController: UIViewController {
  
    private var viewModel = AnimalListViewModel()
    
    private lazy var animalListView: AnimalListView = {
        let view = AnimalListView(viewModel: self.viewModel)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Animal Atlas"
        self.view.backgroundColor = .white
        setupView()
        animalListViewCallback()
    }
    
    private func setupView() {
        self.view.addSubview(animalListView)
        animalListView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        setRightItemNavigation()
    }
    
    private func setRightItemNavigation() {
        if let image = UIImage(systemName: "heart.fill") {
            let rightBarButtonItem = UIBarButtonItem(title: nil, image: image, target: self, action: #selector(rightBarButtonTapped))
            navigationItem.rightBarButtonItem = rightBarButtonItem
        }
    }
    
    @objc private func rightBarButtonTapped() {
        // TODO: Create the Favorite Page
    }
    
    private func animalListViewCallback() {
        animalListView.onCellTapped = { [weak self] animalName in
            Router.shared.showDetail(from: self, animalName: animalName)
        }
    }
}
