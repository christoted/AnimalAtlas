//
//  AnimalListViewController.swift
//  AnimalAtlas
//
//  Created by Christopher Minarto  on 16/01/24.
//

import UIKit
import SnapKit

class AnimalListViewController: UIViewController {
  
    private var animalListView: AnimalListView = {
        let view = AnimalListView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Animal Atlas"
        setupView()
        self.view.backgroundColor = .white
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
        
    }
}
