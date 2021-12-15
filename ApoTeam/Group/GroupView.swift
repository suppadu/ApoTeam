//
//  AddGroupView.swift
//  ApoTeam
//
//  Created by Дмитрий Константинов on 04.12.2021.
//

import UIKit
import SnapKit

class GroupView: UITableViewController, UITextFieldDelegate {
    
    let teamName = UITextField()
    var selected = 0
    var presenter: GroupPresenter
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    init(presenter: GroupPresenter){
        self.presenter = presenter
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        teamName.placeholder = "Team"
        teamName.text = presenter.team.name
        self.navigationItem.titleView = teamName
        self.navigationItem.rightBarButtonItem = .init(title: "Save", style: .plain, target: self, action: #selector(saveTeam))
        self.tableView.register(GroupMemberCell.self, forCellReuseIdentifier: "membercell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "membercell") as! GroupMemberCell
        cell.name.text = presenter.team.members[indexPath.row].name
        cell.status.text = presenter.team.members[indexPath.row].status
        cell.makeInvent(presenter.getInventory(indexPath.row))
        cell.avatar.image = UIImage(data: presenter.team.members[indexPath.row].avatar)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.showRedactView(member: presenter.team.members[indexPath.row], new: presenter.new, delegate: self)
        selected = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        presenter.team.name = textField.text ?? ""
        print(presenter.team.name)
    }
    
    @objc
    func saveTeam() {
        presenter.team.name = teamName.text ?? ""
        presenter.saveTeamInDB()
        navigationController?.popToRootViewController(animated: true)
    }
    
}

extension GroupView: GroupViewDelegate {
    func update(_ member: Member) {
        if presenter.new {
            
        }
        presenter.team.members[selected] = member
        tableView.reloadData()
    }
}
