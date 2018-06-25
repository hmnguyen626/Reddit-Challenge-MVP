//
//  RedditAppChallengeTests.swift
//  RedditAppChallengeTests
//
//  Created by Hieu Nguyen on 6/24/18.
//  Copyright © 2018 HMdev. All rights reserved.
//

import XCTest
@testable import RedditAppChallenge

class RedditAppChallengeTests: XCTestCase {
    
    func testThumbnailImageDataCases(){
        let presenter = PostPresenter()
        
        // Case default
        let testPost = PostData(title: nil, thumbnail: "default", thumbnailImageData: nil, id: nil, subreddit: nil)
        presenter.posts.append(testPost)
        
        presenter.downloadImageData(for: 0) { (x) in
            let image = x
            
            XCTAssertEqual(image, UIImage(named: "default_image.jpeg"))
        }
        
        // Case self
        let testPost2 = PostData(title: nil, thumbnail: "self", thumbnailImageData: nil, id: nil, subreddit: nil)
        presenter.posts.append(testPost2)
        
        presenter.downloadImageData(for: 1) { (x) in
            let image = x
            
            XCTAssertEqual(image, UIImage(named: "default_image.jpeg"))
        }
        
        // Case imageurl
        let url = "https://b.thumbs.redditmedia.com/asq_nHNtmRug4l904iMLsNlUmZ7ATf4jj4gzgjn-O0A.jpg"
        
        let testPost3 = PostData(title: nil, thumbnail: url, thumbnailImageData: nil, id: nil, subreddit: nil)
        presenter.posts.append(testPost3)
        
        presenter.downloadImageData(for: 2) { (x) in
            let image = x
            
            XCTAssertNotEqual(image, UIImage(named: "default_image.jpeg"))
        }
        
    }
    
    func testGetAfterToken(){
        let presenter = PostPresenter()
        presenter.runApiClientNewPost(by: "hot")
        
        sleep(10)
        
        XCTAssertNotNil(presenter.after)
        XCTAssertNotEqual(presenter.after, "")
        
    }
    
}
