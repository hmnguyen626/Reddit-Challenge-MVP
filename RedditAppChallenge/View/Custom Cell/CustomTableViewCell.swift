//
//  CustomTableViewCell.swift
//  RedditAppChallenge
//
//  Created by Hieu Nguyen on 6/25/18.
//  Copyright © 2018 HMdev. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    // ------------------------------------------------------------------------------------------
    // MARK: - Views
    
    let nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        return label
    }()
    
    let bodyLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "HelveticaNeue", size: 15)
        label.numberOfLines = 8
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        return label
    }()
    
    let upVotesLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "HelveticaNeue", size: 15)
        label.textColor = UIColor.red
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let topContainerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let middleContainerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let bottomContainerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // ------------------------------------------------------------------------------------------
    // MARK: - UI setup
    
    private func setup(){
        setupSubViews()
        setupConstraints()
    }
    
    private func setupSubViews(){
        addSubview(topContainerView)
        addSubview(middleContainerView)
        addSubview(bottomContainerView)
        addSubview(nameLabel)
        addSubview(bodyLabel)
        addSubview(upVotesLabel)
    }
    
    private func setupConstraints(){
        topContainerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        topContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        topContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        topContainerView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        middleContainerView.topAnchor.constraint(equalTo: topContainerView.bottomAnchor, constant: 0).isActive = true
        middleContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        middleContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        middleContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true

        bottomContainerView.topAnchor.constraint(equalTo: middleContainerView.bottomAnchor, constant: 0).isActive = true
        bottomContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        bottomContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        bottomContainerView.heightAnchor.constraint(equalToConstant: 25).isActive = true

        nameLabel.topAnchor.constraint(equalTo: topContainerView.topAnchor, constant: 5).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor, constant: 10).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
        bodyLabel.topAnchor.constraint(equalTo: middleContainerView.topAnchor, constant: 10).isActive = true
        bodyLabel.leadingAnchor.constraint(equalTo: middleContainerView.leadingAnchor, constant: 20).isActive = true
        bodyLabel.trailingAnchor.constraint(equalTo: middleContainerView.trailingAnchor, constant: -10).isActive = true
        bodyLabel.bottomAnchor.constraint(equalTo: middleContainerView.bottomAnchor, constant: -10).isActive = true
        
        upVotesLabel.topAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: 5).isActive = true
        upVotesLabel.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor, constant: 20).isActive = true
        upVotesLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        upVotesLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
    }

}
