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
        navCon.viewControllers = [ViewFactory.shared.makeMainView()]
        navCon.title = "Teams"
    }
    
    func makeGroupView(team: Team, new: Bool) {
        navCon.pushViewController(ViewFactory.shared.makeGroupView(team: team, new: new), animated: true)
    }
    
    func makeRedactView(member: Member, new: Bool, delegate: GroupViewDelegate) {
        navCon.present(ViewFactory.shared.makeRedactView(member: member, new: new, delegate: delegate), animated: true){}
    }
}
