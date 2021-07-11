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
    
    private func setupView() {
        backgroundColor = .white
        addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 25).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -25).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }

}
