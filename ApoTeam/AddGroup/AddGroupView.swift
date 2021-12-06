//
//  AddGroupView.swift
//  ApoTeam
//
//  Created by Дмитрий Константинов on 04.12.2021.
//

import UIKit
import SnapKit

class AddGroupView: UITableViewController, UITextFieldDelegate {
    
    let teamName = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        teamName.placeholder = "Team"
        teamName.text = ""
        self.navigationItem.titleView = teamName
        self.tableView.register(MemberCell.self, forCellReuseIdentifier: "membercell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "membercell") as! MemberCell
        cell.name.text = "Name"
        cell.status.text = "Status"
        cell.makeInvent(["☝🏿", "🦾", "🐺", "☝🏿", "🦾", "🐺"])
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let cell = tableView.cellForRow(at: indexPath) as? AddGroupCell else { return }
//        guard let tf = cell.tf!.viewWithTag(1) as? UITextField else { return }
//        print(tf.text!)
//    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let tf = textField.tag
        print(tf)
    }
}
