//
//  AnimalFavoriteViewController.swift
//  AnimalAtlas
//
//  Created by Christopher Minarto  on 18/01/24.
//

import UIKit

class AnimalFavoriteViewController: UIViewController {
    
    private lazy var animalFavoriteView: AnimalFavoriteView = {
        let view = AnimalFavoriteView(viewModel: self.viewModel)
        return view
    }()
    
    var viewModel = AnimalFavoriteViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.navigationItem.title = "Favorite"
        
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animalFavoriteView.getFavoritePhoto()
    }
    
    private func setRightItemNavigation() {
        if let image = UIImage(systemName: "line.3.horizontal.decrease.circle") {
            let rightBarButtonItem = UIBarButtonItem(title: nil, image: image.withTintColor(.black), target: self, action: #selector(rightBarButtonTapped))
            navigationItem.rightBarButtonItem = rightBarButtonItem
        }
    }
    
    @objc private func rightBarButtonTapped() {
        showActionSheet()
    }
    
    private func setupView() {
        setRightItemNavigation()
        self.view.addSubview(animalFavoriteView)
        
        animalFavoriteView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    private func showActionSheet() {
        let alertController = UIAlertController(title: "Filter By", message: nil, preferredStyle: .actionSheet)
        
        let optionAll = UIAlertAction(title: Constant.all, style: .default) { [weak self] _ in
            self?.viewModel.getAnimalPhotoLiked()
        }

        let option1Action = UIAlertAction(title: Constant.elephant, style: .default) { [weak self] _ in
            self?.viewModel.filterAnimalImage(animalName: Constant.elephant)
        }

        let option2Action = UIAlertAction(title: Constant.lion, style: .default) {[weak self] _ in
            self?.viewModel.filterAnimalImage(animalName: Constant.lion)
          }

        let option3Action = UIAlertAction(title: Constant.fox, style: .default) {[weak self] _ in
            self?.viewModel.filterAnimalImage(animalName: Constant.fox)
          }
        
        let option4Action = UIAlertAction(title: Constant.dog, style: .default) {[weak self] _ in
            self?.viewModel.filterAnimalImage(animalName: Constant.dog)
          }
        
        let option5Action = UIAlertAction(title: Constant.shark, style: .default) {[weak self] _ in
            self?.viewModel.filterAnimalImage(animalName: Constant.shark)
          }
        
        let option6Action = UIAlertAction(title: Constant.turtle, style: .default) {[weak self] _ in
            self?.viewModel.filterAnimalImage(animalName: Constant.turtle)
          }
        
        let option7Action = UIAlertAction(title: Constant.whale, style: .default) {[weak self] _ in
            self?.viewModel.filterAnimalImage(animalName: Constant.whale)
          }
        
        let option8Action = UIAlertAction(title: Constant.penguin, style: .default) {[weak self] _ in
            self?.viewModel.filterAnimalImage(animalName: Constant.penguin)
          }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                  // Handle cancel action
                  print("Cancelled")
              }
        
        alertController.addAction(optionAll)
        alertController.addAction(option1Action)
        alertController.addAction(option2Action)
        alertController.addAction(option3Action)
        alertController.addAction(option4Action)
        alertController.addAction(option5Action)
        alertController.addAction(option6Action)
        alertController.addAction(option7Action)
        alertController.addAction(option8Action)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
