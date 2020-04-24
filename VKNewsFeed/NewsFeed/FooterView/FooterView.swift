//
//  FooterView.swift
//  VKNewsFeed
//
//  Created by Александр Цветков on 24.04.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class FooterView: UIView {
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(hex: "A1A5A9")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        return loader
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        addSubview(loader)
        
        label.anchor(top: topAnchor,
                      leading: leadingAnchor,
                      bottom: nil, trailing: trailingAnchor,
                      padding: UIEdgeInsets(top: 8, left: 20, bottom: 999, right: 20))
        loader.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loader.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8).isActive = true
    }
    
    func showLoader() {
        loader.startAnimating()
    }
    
    func setTitle(title: String?) {
        loader.stopAnimating()
        label.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
