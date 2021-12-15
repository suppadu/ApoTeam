//
//  SceneFactory.swift
//  ApoTeam
//
//  Created by Дмитрий Константинов on 06.12.2021.
//

import Foundation

class ViewFactory {
    static let shared = ViewFactory()
    private init() {}
    
    func makeMainView() -> MainView {
        return MainView(presenter: MainPresenter(teams: Repository.shared.teams))
    }
    
    func makeGroupView(team: Team, new: Bool) -> GroupView {
        return GroupView(presenter: GroupPresenter(team: team, new: new))
    }
    
    func makeRedactView(member: Member, new: Bool, delegate: GroupViewDelegate) -> MemberRedactView {
        let mrv = MemberRedactView()
        mrv.presenter = MemberRedactPresenter(member: member, new: new)
        mrv.delegate = delegate
        return mrv
    }
}
