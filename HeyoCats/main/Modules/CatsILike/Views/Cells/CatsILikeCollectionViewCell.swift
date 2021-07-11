//
//  CatsILikeCollectionViewCell.swift
//  HeyoCats
//
//  Created by Mojisola Adebiyi on 08/07/2021.
//

import UIKit

class CatsILikeCollectionViewCell: UICollectionViewCell {
    
    let id = UUID()
    static let reuseId = "\(CatsILikeCollectionViewCell.self)"
    
    var didPressLike: (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupTapAction()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        catImageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTapAction() {
        likeImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didPressLikeImage)))
    }

    @objc private func didPressLikeImage() {
        didPressLike?()
    }
    
    let catImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
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
        let view = UIImageView(image: UIImage(named: "like_filled"))
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
        view.axis = .vertical
        view.spacing = 5
        view.alignment = .fill
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func loadImageFrom(url: String) {
        ImageCacheManager.fetchImageData(with: id.uuidString, from: url, completion: { data in
            DispatchQueue.main.async {[weak self] in
                self?.catImageView.alpha = 0
                UIView.animate(withDuration: 0.3) {
                    self?.catImageView.image = UIImage(data: data as Data)
                    self?.catImageView.alpha = 1
                }
            }
        })
    }

    
    func configureCell(with data: Cat) {
        catNameLabel.text = data.name
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
