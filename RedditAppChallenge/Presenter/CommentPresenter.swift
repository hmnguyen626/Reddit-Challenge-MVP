//
//  CommentPresenter.swift
//  RedditAppChallenge
//
//  Created by Hieu Nguyen on 6/25/18.
//  Copyright © 2018 HMdev. All rights reserved.
//

import Foundation

// Protocol to handle delegates/datasource of VC
protocol CommentVC: NSObjectProtocol {
    func startLoading()
    func finishLoading()
}

class CommentPresenter {
    
    // API Client
    let redditAPIClient = APIClientService()
    
    // Model
    var comments = [CommentData]()
    
    
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
    // MARK: - Function that makes a https get request to reddit api and then assign data to model
    func runAPIClient(by subreddit: String, by id: String){
        self.comments = []
        
        // Call startloading to turn delegates & datasource = nil
        commentView?.startLoading()
        
        guard let url = URL(string: "https://www.reddit.com/r/\(subreddit)/comments/\(id).json") else { return }
        
        redditAPIClient.makeCommentRequest(url: url) {
            (comments) in
            
            self.comments = comments
            
            // Resume by turning delegates & datasource = self, within CommentViewController
            self.commentView?.finishLoading()
        }
    }
    
}
