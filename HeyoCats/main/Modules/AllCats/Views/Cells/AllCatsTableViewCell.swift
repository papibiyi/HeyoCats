//
//  AllCatsTableViewCell.swift
//  HeyoCats
//
//  Created by Mojisola Adebiyi on 08/07/2021.
//

import UIKit

class AllCatsTableViewCell: UITableViewCell {
    
    let id = UUID()
    static let reuseId = "\(AllCatsTableViewCell.self)"
    
    var didPressLike: (() -> ())?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupTapAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        catImageView.image = nil
    }
    
    private func setupTapAction() {
        likeImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didPressLikeImage)))
    }
    
    @objc private func didPressLikeImage() {
        didPressLike?()
    }
    
    let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.startAnimating()
        view.hidesWhenStopped = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var leftView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        view.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(activityIndicator)
        view.addSubview(catImageView)
        catImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        catImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        catImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        catImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let catImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let catNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "primary_text")
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    lazy var likeImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "like_unfilled"))
        view.isUserInteractionEnabled = true
        view.heightAnchor.constraint(equalToConstant: 18).isActive = true
        view.widthAnchor.constraint(equalToConstant: 18).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var hStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [leftView, catNameLabel, likeImageView])
        view.spacing = 15
        view.alignment = .center
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func configureCell(with data: Cat) {
        catNameLabel.text = data.name
    }
    
    func loadImageFrom(url: String) {
        ImageCacheManager.fetchImageData(with: id.uuidString, from: url, completion: { data in
            DispatchQueue.main.async {[weak self] in
                self?.catImageView.alpha = 0
                UIView.animate(withDuration: 0.3) {
                    self?.activityIndicator.stopAnimating()
                    self?.catImageView.image = UIImage(data: data as Data)
                    self?.catImageView.alpha = 1
                }
            }
        })
    }
    
    deinit {
        DispatchQueue.global(qos: .background).async {
            ImageCacheManager.taskDictionary.removeValue(forKey: "\(self.id.uuid)")
        }
    }
    
    func isFavourited(_ bool: Bool) {
        likeImageView.image = bool ? UIImage(named: "like_filled") : UIImage(named: "like_unfilled")
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
