//
//  CatsILikeView.swift
//  HeyoCats
//
//  Created by Mojisola Adebiyi on 11/07/2021.
//

import UIKit

class CatsILikeView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .vertical
        viewLayout.minimumLineSpacing = 25
        viewLayout.minimumInteritemSpacing = 25
        let view = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(CatsILikeCollectionViewCell.self, forCellWithReuseIdentifier: CatsILikeCollectionViewCell.reuseId)
        return view
    }()
    
    let catsILikeLabel: UILabel = {
        let label = UILabel()
        label.text = "Cats I Like"
        label.textColor = UIColor(named: "primary_text")
        label.font = UIFont.systemFont(ofSize: 16)
        label.backgroundColor = UIColor(named: "background")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [catsILikeLabel, collectionView])
        view.axis = .vertical
        view.spacing = 25
        view.alignment = .fill
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func setupView() {
        backgroundColor = .white
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 25).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -25).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }

}
