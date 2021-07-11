//
//  UICollectionView+Extension.swift
//  HeyoCats
//
//  Created by Mojisola Adebiyi on 11/07/2021.
//

import UIKit

extension UICollectionView {
    
    enum EmptyStateMode {
        case loading(message: String)
        case noData(message: String?, image: UIImage?)
    }
        
    func setEmptyView(_ mode: EmptyStateMode) {
        var message: String?
        var image: UIImage?
        
        switch mode {
        case .loading(let text):
            message = text
        case .noData(let messageText, let stateImage):
            message = messageText
            image = stateImage
        }
        
        let emptyView = UIView(frame: self.frame)
        
        let activityIndicator: UIActivityIndicatorView = {
            let view = UIActivityIndicatorView()
            view.startAnimating()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        let imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = image
            imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        let imageContentView: UIView = {
            let view = UIView()
            switch mode {
            case .loading:
                view.addSubview(activityIndicator)
                activityIndicator.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
                activityIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
                activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            case .noData:
                view.addSubview(imageView)
                imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
                imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
                imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            }
            return view
        }()
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 2
            label.text = message
            label.textAlignment = .center
            return label
        }()
        
        let stackView: UIStackView = {
            let view = UIStackView(arrangedSubviews: [imageContentView, titleLabel])
            view.axis = .vertical
            view.spacing = 8
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        emptyView.addSubview(stackView)
        
        stackView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 24).isActive = true
        stackView.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -24).isActive = true

        self.backgroundView = emptyView
    }
    
    func removeEmptyView(){
        self.backgroundView = nil
    }
}


