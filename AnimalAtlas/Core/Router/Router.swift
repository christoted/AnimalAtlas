//
//  Router.swift
//  AnimalAtlas
//
//  Created by Christopher Minarto  on 17/01/24.
//

import UIKit

class Router {
   
    static let shared = Router()
    
    func showDetail(from presentingView: UIViewController? = nil, animalName: String) {
        let controller = AnimalDetailViewController()
        controller.animalName = animalName
        if let presentingView = presentingView {
            presentingView.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func showFavorite(from presentingView: UIViewController? = nil) {
        let controller = AnimalFavoriteViewController()
        if let presentingView = presentingView {
            presentingView.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
