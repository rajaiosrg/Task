//
//  UserAPIRequest.swift
//  DocTalkTask
//
//  Created by Raja Earla on 13/06/18.
//  Copyright © 2018 Raja Earla. All rights reserved.
//

import Foundation

class UserAPIRequest: APIRequest {
    var method = RequestType.GET
    var path = "search/users"
    var parameters = [String: String]()
    
    init(name: String) {
        parameters["q"] = name
        parameters["followers"] = "1..1000"
    }
}
