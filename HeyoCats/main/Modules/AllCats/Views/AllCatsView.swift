//
//  AllCatsView.swift
//  HeyoCats
//
//  Created by Mojisola Adebiyi on 11/07/2021.
//

import UIKit

class AllCatsView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(AllCatsTableViewCell.self, forCellReuseIdentifier: AllCatsTableViewCell.reuseId)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let allCatsLabel: UILabel = {
        let label = UILabel()
        label.text = "All Cats"
        label.textColor = UIColor(named: "primary_text")
        label.font = UIFont.systemFont(ofSize: 16)
        label.backgroundColor = UIColor(named: "background")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return label
    }()

    
    private func setupView() {
        backgroundColor = .white
        addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        tableView.leftAnchor.constraint(equalTo: leftAnchor, constant: 25).isActive = true
        tableView.rightAnchor.constraint(equalTo: rightAnchor, constant: -25).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }


}
