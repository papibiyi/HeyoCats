//
//  CatsILikeCollectionViewCell.swift
//  HeyoCats
//
//  Created by Mojisola Adebiyi on 08/07/2021.
//

import UIKit

class CatsILikeCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        let view = UIStackView(arrangedSubviews: [catNameLabel, likeImageView])
        view.spacing = 15
        view.alignment = .center
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var vStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [catImageView, hStack])
        view.spacing = 5
        view.alignment = .fill
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func configureCell() {
        
    }
    
    private func setupView() {
        backgroundColor = .clear
        contentView.addSubview(vStack)
        vStack.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        vStack.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        vStack.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        vStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

}
