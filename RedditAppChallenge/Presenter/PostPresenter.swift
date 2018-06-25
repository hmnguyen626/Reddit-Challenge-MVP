//
//  PostPresenter.swift
//  RedditAppChallenge
//
//  Created by Hieu Nguyen on 6/24/18.
//  Copyright © 2018 HMdev. All rights reserved.
//

import UIKit

protocol RedditVC: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func loadMore()
    
}

// Our presenter will handle our model and it's modifications to keep the logic away from the view.  The view should know little or nothing about the business logic.
class PostPresenter {
    
    // The APIClientService object I created is to further decouple the presenter(s) from the API.  This will allow for better code reusability and abstraction
    let redditAPIClient = APIClientService()
    
    // Model
    var posts = [PostData]()
    var after = ""
    
    init(){
        runApiClient(by: "top")
    }
    
    // ------------------------------------------------------------------------------------------
    // MARK: - Presenter's control over RedditCollectionViewController's life cycle
    weak private var redditView: RedditVC?
    
    func attachView(view: RedditVC){
        redditView = view
        
    }
    
    func detachView(){
        redditView = nil
    }
    
    // ------------------------------------------------------------------------------------------
    // MARK: - Function that makes a https get request to reddit api
    func runApiClient(by endpoint: String){
        self.posts = []
        
        // Reference our view and set delegates = nil, so loaded data can be downloaded before view use data as datasources
        redditView?.startLoading()
        
        guard let url = URL(string: "https://www.reddit.com/r/all/\(endpoint).json") else { return }
        
        // Make a request to our APIClient and set model data from completion block
        redditAPIClient.makeThreadRequest(url: url) {
            (posts, after) in
            
            self.posts = posts
            self.after = after
            self.redditView?.finishLoading()
            
        }
        
    }
    
    // ------------------------------------------------------------------------------------------
    // Presenter will download the imageData and return Data back to the view
    // MARK: - Download Image Data and send to view
    func downloadImageData(for index: Int, completion: @escaping (UIImage?) -> Void){
        
        guard let url = URL(string: posts[index].thumbnail!) else { return }
        
        // Reddit API returns a thumbnail string, but there are 3 cases: default, self, and an imageurl
        // default: is a gif/video
        // self: is an empty body text, which only has a title or reference to another reddit article
        // imageurl: a link to an imageurl
        // For default and self, I will set the images to a default_image.jpeg, but will retrieve the imagedata for imageurl
        if posts[index].thumbnail == "default" {
            let image = UIImage(named: "default_image.jpeg")
            completion(image)
        }
        else if posts[index].thumbnail == "self" {
            let image = UIImage(named: "default_image.jpeg")
            completion(image)
        }
        
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            if error != nil {
                print(error!)
            } else {
                if let data = data {
                    
                    let image = UIImage(data: data)
                    completion(image)
                }
            }
        }.resume()
    }

}







