//
//  MainPresenter.swift
//  ApoTeam
//
//  Created by Дмитрий Константинов on 03.12.2021.
//

import Foundation
import RealmSwift

protocol MainPresenterProtocol {
    var teams: Results<Team> { get set }
    func openGroup(team: Team, new: Bool)
    func getAvatars(_ numberTeam: Int) -> [Data]
}

class MainPresenter: MainPresenterProtocol {
    var teams: Results<Team>
    
    init(teams: Results<Team>){
        self.teams = teams
    }
    
    func openGroup(team: Team = Repository.shared.newTeam, new: Bool = true) {
        Router.shared.makeGroupView(team: team, new: new)
    }
    
    func getAvatars(_ numberTeam: Int) -> [Data] {
        var avatars: [Data] = []
        for member in teams[numberTeam].members {
            avatars.append(member.avatar)
        }
        return avatars
    }
    
    func getNewTeams() {
        teams = Repository.shared.teams
    }
}

//NetworkService().getRandomUser() { data in
//    let status = try? JSONDecoder().decode(RandomUser.self, from: data)
//    print(status)
//}
//vc?.tableView.reloadData()
