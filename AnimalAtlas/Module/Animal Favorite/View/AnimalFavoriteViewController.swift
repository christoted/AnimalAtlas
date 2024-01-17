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

        let option1Action = UIAlertAction(title: "Elephant", style: .default) { _ in
              print("Option 1 selected")
          }

        let option2Action = UIAlertAction(title: "Lion", style: .default) { _ in
              print("Option 2 selected")
          }

        let option3Action = UIAlertAction(title: "Fox", style: .default) { _ in
              print("Cancelled")
          }
        
        let option4Action = UIAlertAction(title: "Dog", style: .default) { _ in
              print("Cancelled")
          }
        
        let option5Action = UIAlertAction(title: "Shark", style: .default) { _ in
              print("Cancelled")
          }
        
        let option6Action = UIAlertAction(title: "Turle", style: .default) { _ in
              print("Cancelled")
          }
        
        let option7Action = UIAlertAction(title: "Whale", style: .default) { _ in
              print("Cancelled")
          }
        
        let option8Action = UIAlertAction(title: "Penguin", style: .default) { _ in
              print("Cancelled")
          }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                  // Handle cancel action
                  print("Cancelled")
              }

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
