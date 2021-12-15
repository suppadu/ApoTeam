//
//  AddGroupPresenter.swift
//  ApoTeam
//
//  Created by Дмитрий Константинов on 04.12.2021.
//

import Foundation
import RealmSwift

protocol GroupViewDelegate: AnyObject {
    func update(_ member: Member)
}

class GroupPresenter {
    var team: Team
    var new: Bool
    var teamInDB: Team? = nil
    
    init(team: Team, new: Bool) {
        self.team = team
        self.new = new
        if !new {
            self.teamInDB = team
            self.team = Team(value: team)
        }
    }
    
    func getInventory(_ number: Int) -> [String] {
        var inventory: [String] = []
        for invent in team.members[number].invent {
            inventory.append(invent)
        }
        return inventory
    }
    
    func showRedactView(member: Member, new: Bool, delegate: GroupViewDelegate) {
        Router.shared.makeRedactView(member: member, new: new, delegate: delegate)
    }
    
    func saveTeamInDB() {
        if new {
            Repository.shared.saveTeamInDB(team: team)
        } else {
            self.teamInDB = Team(value: team)
            Repository.shared.editTeamInDB(team: teamInDB!)
        }
    }
}
