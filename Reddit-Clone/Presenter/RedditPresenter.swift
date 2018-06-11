//
//  RedditPresenter.swift
//  Reddit-Clone
//
//  Created by Maria Xina Rae Torres on 24/05/2018.
//  Copyright © 2018 Maria Xina Rae Torres. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

protocol RedditPresenterDelegate {
    func showLoadingReddit()
    func showReddit(_ reddits: [RedditDataModel])
    func showRedditError(_ errorString: String)
}

class RedditPresenter {
    
    // MARK: - Properties
    
    var redditRepository: RedditRepository
    var view: RedditPresenterDelegate
    
    // MARK: - Functions
    
    required init(view: RedditPresenterDelegate, redditRepository: RedditRepository){
        self.view = view
        self.redditRepository = redditRepository
    }
    
    func loadRedditData(keywords: String) {
        // 1 - show loading
        self.view.showLoadingReddit()
        
        // 2 - async network call
        redditRepository.getRedditData_New(keywords: keywords, success: { reddits in
            
            // 3 - success, call showReddit
            self.view.showReddit(reddits)
            
        }, error: { error in
            
            // 4 - failure, show error
            
            self.view.showRedditError(error)
        })
    }
}


