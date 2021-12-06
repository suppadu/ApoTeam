//
//  MainPresenter.swift
//  ApoTeam
//
//  Created by Дмитрий Константинов on 03.12.2021.
//

import Foundation

protocol MainPresenterProtocol {
    var teams: [Team] { get set }
    func openGroup(_ new: Bool)
    func getAvatars(_ numberTeam: Int) -> [Data]
}

class MainPresenter: MainPresenterProtocol {
    
    var teams: [Team]
    
    init(teams: [Team]){
        self.teams = teams
    }
    
    func openGroup(_ new: Bool) {
        Router.shared.makeGroupView(new)
    }
    
    func getAvatars(_ numberTeam: Int) -> [Data] {
        var avatars: [Data] = []
        for member in teams[numberTeam].members {
            avatars.append(member.avatar)
        }
        return avatars
    }
}
