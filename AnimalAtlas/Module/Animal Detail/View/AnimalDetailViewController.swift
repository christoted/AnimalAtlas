//
//  AnimalDetailViewController.swift
//  AnimalAtlas
//
//  Created by Christopher Minarto  on 17/01/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class AnimalDetailViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let viewModel = AnimalDetailViewModel()
    
    private lazy var animalDetailView: AnimalDetailView = {
        let view = AnimalDetailView(viewModel: self.viewModel)
        return view
    }()
    
    var animalName: String = "" {
        didSet {
            animalDetailView.animalName = animalName
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        setupView()
    }
    
    private func setupView() {
        self.view.addSubview(animalDetailView)
        
        animalDetailView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }

}
