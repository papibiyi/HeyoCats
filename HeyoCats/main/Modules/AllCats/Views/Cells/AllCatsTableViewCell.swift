//
//  AllCatsTableViewCell.swift
//  HeyoCats
//
//  Created by Mojisola Adebiyi on 08/07/2021.
//

import UIKit

class AllCatsTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let catImageView: UIImageView = {
        let view = UIImageView()
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        view.widthAnchor.constraint(equalToConstant: 40).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let catNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "primary_text")
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let likeImageView: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = true
        view.heightAnchor.constraint(equalToConstant: 18).isActive = true
        view.widthAnchor.constraint(equalToConstant: 18).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var hStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [catImageView, catNameLabel, likeImageView])
        view.spacing = 15
        view.alignment = .center
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func configureCell() {
        
    }
    
    private func setupView() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(hStack)
        hStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        hStack.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        hStack.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        hStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }

}
