//
//  GenericViewController.swift
//  HeyoCats
//
//  Created by Mojisola Adebiyi on 11/07/2021.
//

import UIKit
import Combine

class GenericViewController<Content: UIView>: UIViewController {
    var contentView: Content
    
    var cancellables : Set<AnyCancellable> = []


    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        contentView = Content()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupCustomView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCustomView() {
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}
