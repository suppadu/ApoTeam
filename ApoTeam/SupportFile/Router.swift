//
//  Router.swift
//  ApoTeam
//
//  Created by Дмитрий Константинов on 06.12.2021.
//

import Foundation
import UIKit

class Router {
    static let shared = Router(UINavigationController())
    let navCon: UINavigationController
    
    private init(_ navCon: UINavigationController) {
        self.navCon = navCon
        makeMainView()
    }
    
    private func makeMainView() {
        navCon.viewControllers = [SceneFactory.shared.makeMainView()]
        navCon.title = "Teams"
    }
    
    func makeGroupView(_ new: Bool) {
        navCon.pushViewController(SceneFactory.shared.makeGroupView(), animated: true)
//        navCon.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
}
