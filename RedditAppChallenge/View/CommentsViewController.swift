//
//  CommentsViewController.swift
//  RedditAppChallenge
//
//  Created by Hieu Nguyen on 6/24/18.
//  Copyright © 2018 HMdev. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // VC's Presenter to handle business logic
    let presenter = CommentPresenter()
    var subreddit: String?
    var id: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentsTableView.delegate = self
        commentsTableView.dataSource = self
        
        setup()
    }
    
    // ------------------------------------------------------------------------------------------
    // MARK: - Tableview Delegate Methods
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // Set cell background color clear so that our tableview's background color is correct on loadup
        cell.backgroundColor = UIColor.clear
        
    }
    
    // ------------------------------------------------------------------------------------------
    // MARK: - Tableview Datasource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = commentsTableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        
        cell.nameLabel.text = "Hieumongous Nguyen"
        cell.bodyLabel.text = "What you're using isn't a segue. This is just pushing a NEW instance (not the same one) of view controller onto the nav stack."
        cell.upVotesLabel.text = "7046"
        
        return cell
    }
    
    // ------------------------------------------------------------------------------------------
    // MARK: - Views
    let commentsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 200
        tableView.backgroundColor = UIColor.darkGray
        
        
        // Register our custom cell
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
        
        return tableView
    }()

    
    // ------------------------------------------------------------------------------------------
    // MARK: - UI Setup
    private func setupMainView(){
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationItem.title = "Comments"

    }
    
    private func setup(){
        setupMainView()
        setupSubViews()
        setupConstraints()
    }
    
    private func setupSubViews(){
        view.addSubview(commentsTableView)

    }
    
    private func setupConstraints(){
        commentsTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        commentsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        commentsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        commentsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true

        
    }
    
    
}
