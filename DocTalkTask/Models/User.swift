//
//  User.swift
//  DocTalkTask
//
//  Created by Raja Earla on 13/06/18.
//  Copyright © 2018 Raja Earla. All rights reserved.
//

import Foundation

struct User : Codable {
    let login : String
    let id : Int
    let node_id : String
    let avatar_url : String
    let gravatar_id : String
    let html_url : String
    let followers_url : String
    let subscriptions_url : String
    let organizations_url : String
    let repos_url : String
    let received_events_url : String
    let type : String
    let score : Double
    
    
}
