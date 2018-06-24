//
//  APIPresenter.swift
//  RedditAppChallenge
//
//  Created by Hieu Nguyen on 6/23/18.
//  Copyright © 2018 HMdev. All rights reserved.
//

import Foundation

// I am seperating the API layer from the presenter to further decouple our application. -Hieu
class RedditAPIClient {
    
    var json: JSONReddit?
    
    init(){
        
    }
    
    // ------------------------------------------------------------------------------------------
    // Use URLSession to make a request to reddit api with a given subreddit string
    // MARK: - Function that makes a https get request to reddit api
    func grabRedditData(by endpoint: String){
        
        guard let url = URL(string: "https://www.reddit.com/r/all/\(endpoint).json") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) {
            (data, response, error) in
            
            if let data = data {
                do {
                    // Decode our data with codable.  See "Model/Reddit Object"
                    let json = try JSONDecoder().decode(JSONReddit.self, from: data)
                    self.json = json
                    
                    
                } catch {
                    print("error")
                }
            }
            
            }.resume()
    }
    
    
}


