//
//  APIPresenter.swift
//  RedditAppChallenge
//
//  Created by Hieu Nguyen on 6/23/18.
//  Copyright © 2018 HMdev. All rights reserved.
//

import Foundation

// I am seperating the API layer from the presenter to further decouple our application. -Hieu
class RedditAPI {
    var posts = [PostData]()
    var after = ""
    
    init(){
        //self.grabRedditData(by: "hot")
    }
    
    // ------------------------------------------------------------------------------------------
    // Use URLSession to make a request to reddit api with a given subreddit string
    // MARK: - Function that makes a https get request to reddit api
    // Link: https://stackoverflow.com/questions/35357807/running-one-function-after-another-completes
    func grabRedditData(by endpoint: String, complete: @escaping ()->()){
        
        guard let url = URL(string: "https://www.reddit.com/r/all/\(endpoint).json") else { return }
        let session = URLSession.shared
        
        session.dataTask(with: url) {
            (data, response, error) in

            if let data = data {
                do {
                    // Decode our data with codable.  See "/Model/Decodables"
                    let json = try JSONDecoder().decode(JSONReddit.self, from: data)
                    
                    // Map our list of posts to an array on non-nil PostData objects
                    self.posts = json.data.children.compactMap{ $0.data }
                    
                    if let after = json.data.after {
                        self.after = after
                    }
                    
                    complete()  // Calls completion block once this asynch. proccess is complete
                } catch {
                    print("error")
                }
            }
        }.resume()
    }
    
    // ------------------------------------------------------------------------------------------
}


