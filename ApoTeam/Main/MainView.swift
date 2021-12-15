//
//  ViewController.swift
//  ApoTeam
//
//  Created by Дмитрий Константинов on 01.12.2021.
//

import UIKit

class MainView: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    var presenter: MainPresenter
    
    init(presenter: MainPresenter){
        self.presenter = presenter
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter.getNewTeams()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        print("view load")
        super.viewDidLoad()
        self.title = self.navigationController?.title
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        
        self.navigationItem.searchController = searchController
        self.navigationItem.leftBarButtonItem = .init(image: UIImage(systemName: "line.3.horizontal.decrease"), style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = .init(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(openNewTeam))
        self.tableView.register(CellView.self, forCellReuseIdentifier: "cell")
        self.tableView.separatorStyle = .none
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.teams.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CellView
        cell.title.text = presenter.teams[indexPath.row].name
        cell.makeImage(presenter.getAvatars(indexPath.row))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.openGroup(team: presenter.teams[indexPath.row], new: false)
    }
    
    @objc
    func openNewTeam() {
        presenter.openGroup()
    }
}

