//
//  CustomCollectionViewCell.swift
//  RedditChallenge
//
//  Created by Hieu Nguyen on 6/22/18.
//  Copyright © 2018 HMdev. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // ------------------------------------------------------------------------------------------
    // MARK: - Views
    let postTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.numberOfLines = 3
        //label.sizeToFit()
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let postSubredditNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        return label
    }()
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let bottomContainerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        return indicator
    }()
    
    // ------------------------------------------------------------------------------------------
    // MARK: - UI setup
    
    private func setup(){
        setupSubViews()
        setupConstraints()
    }
    
    private func setupSubViews(){
        self.backgroundColor = UIColor.black
        
        addSubview(postTitleLabel)
        addSubview(postSubredditNameLabel)
        addSubview(thumbnailImageView)
        addSubview(bottomContainerView)
        addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        postTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        postTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        postTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        postTitleLabel.bottomAnchor.constraint(equalTo: thumbnailImageView.topAnchor, constant: -10).isActive = true
        
        bottomContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        bottomContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        bottomContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        bottomContainerView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        postSubredditNameLabel.topAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: 5).isActive = true
        postSubredditNameLabel.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor, constant: 15).isActive = true
        postSubredditNameLabel.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor, constant: 0).isActive = true
        postSubredditNameLabel.bottomAnchor.constraint(equalTo: bottomContainerView.bottomAnchor, constant: -5).isActive = true
        
        thumbnailImageView.topAnchor.constraint(equalTo: postTitleLabel.bottomAnchor, constant: 10).isActive = true
        thumbnailImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        thumbnailImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        thumbnailImageView.bottomAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: 5).isActive = true
    }
   
    
}
