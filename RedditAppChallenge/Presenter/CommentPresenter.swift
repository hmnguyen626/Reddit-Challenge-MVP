//
//  CommentPresenter.swift
//  RedditAppChallenge
//
//  Created by Hieu Nguyen on 6/25/18.
//  Copyright © 2018 HMdev. All rights reserved.
//

import Foundation

protocol CommentVC: NSObjectProtocol {
    func startLoading()
    func finishLoading()
}

class CommentPresenter {
    
    // API Client
    let redditAPIClient = APIClientService()
    
    // Model
    var comments = [CommentData]()
    
    init(){
        runAPIClient(by: "gameofthrones", by: "8taadc")
    }
    
    // ------------------------------------------------------------------------------------------
    // MARK: - Presenter's control over CommentViewController's life cycle
    weak private var commentView: CommentVC?
    
    func attachView(view: CommentVC){
        commentView = view
        
    }
    
    func detachView(){
        commentView = nil
    }
    
    // ------------------------------------------------------------------------------------------
    // MARK: -
    func runAPIClient(by subreddit: String, by id: String){
        self.comments = []
        
        //startloading()
        
        guard let url = URL(string: "https://www.reddit.com/r/\(subreddit)/comments/\(id).json") else { return }
        
        redditAPIClient.makeCommentRequest(url: url) {
            (comments) in
            
            self.comments = comments
            print(self.comments)
            
            // End loading
        }
    }
    
}
