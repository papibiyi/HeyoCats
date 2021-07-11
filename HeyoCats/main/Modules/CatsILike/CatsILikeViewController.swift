//
//  CatsILikeViewController.swift
//  HeyoCats
//
//  Created by Mojisola Adebiyi on 07/07/2021.
//

import UIKit

class CatsILikeViewController: GenericViewController<CatsILikeView> {
    
    var cats: [Cat] {
        return CatsPersistenceManager.shared.load()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contentView.collectionView.reloadData()
    }
    
    private func setupCollectionView() {
        contentView.collectionView.delegate = self
        contentView.collectionView.dataSource = self
    }
}

extension CatsILikeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatsILikeCollectionViewCell.reuseId, for: indexPath) as! CatsILikeCollectionViewCell
        cell.configureCell(with: cats[indexPath.row])
        cell.didPressLike = {
            CatsPersistenceManager.shared.remove(cat: self.cats[indexPath.row])
            collectionView.reloadData()
        }
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cats.isEmpty ? contentView.collectionView.setEmptyView(.noData(message: "You don't like any cat\n😿", image: nil)) : contentView.collectionView.removeEmptyView()
        return cats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.width - 75) / 2
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let url = cats[indexPath.row].image?.url ?? ""
        let cell = cell as? CatsILikeCollectionViewCell
        DispatchQueue.global(qos: .background).async {
            cell?.loadImageFrom(url: url)
        }
    }
}
