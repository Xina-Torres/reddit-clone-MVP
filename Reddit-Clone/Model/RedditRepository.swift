//
//  RedditRepository.swift
//  Reddit-Clone
//
//  Created by Maria Xina Rae Torres on 25/05/2018.
//  Copyright © 2018 Maria Xina Rae Torres. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class RedditRepository{
    
    var reddit = [RedditDataModel]()
    var anyObject = [Any]()
    var subs = [SubscribeDataModel]()
    
    typealias RedditDataHandling = (([RedditDataModel]?) -> Void)
    typealias Completion = ((_ data: Data?, _ status: Int,_ error: Error?) -> Bool)
    let baseURL = "https://api.reddit.com/r/"
    
    func getRedditData_New(keywords: String?,
                           success: @escaping (([RedditDataModel]) -> Void),
                           error: @escaping ((String) -> Void)) {
        let checkedKeyword = (keywords == "") ? "aww" : keywords
        let finalKeywords = checkedKeyword?.replacingOccurrences(of: " ", with: "+").lowercased()
        let searchURL = URL.init(string: baseURL + (finalKeywords ?? ""))!
        let r = Alamofire.request(searchURL, method: .get)
        r.responseJSON{ (response) in
            switch response.result {
            case .success(_):
                let redditJSON : JSON = JSON(response.result.value!)
                self.storeRedditData(json: redditJSON)
                success(self.reddit)
            case .failure(let e):
                error(e.localizedDescription)
            }
        }
    }
    
    func storeRedditData(json: JSON) {
        anyObject.removeAll()
        reddit.removeAll()
        subs.removeAll()
        subs.append(SubscribeDataModel())
        let children = json["data"]["children"].arrayValue.count
        
        for child in 0...children - 1{
            var redditDataModel = RedditDataModel()
            redditDataModel.subRedditImage = json["data"]["children"][child]["data"]["thumbnail"].stringValue
            redditDataModel.subReddit = json["data"]["children"][child]["data"]["subreddit_name_prefixed"].stringValue
            redditDataModel.user = "u/" + json["data"]["children"][child]["data"]["author"].stringValue
            redditDataModel.title = json["data"]["children"][child]["data"]["title"].stringValue
            redditDataModel.articleImage = json["data"]["children"][child]["data"]["preview"]["images"][0]["source"]["url"].stringValue
            redditDataModel.articleSubtitle = json["data"]["children"][child]["data"]["selftext"].stringValue
            redditDataModel.time = json["data"]["children"][child]["data"]["created_utc"].doubleValue
            reddit.append(redditDataModel)
        }
    
        for i in 0...reddit.count - 1{
            if i%4 == 0{
                anyObject.append(subs[0])
                anyObject.append(reddit[i])
            }else{
                anyObject.append(reddit[i])
            }
        }
    }
}
