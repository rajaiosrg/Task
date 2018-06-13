//
//  APIManager.swift
//  DocTalkTask
//
//  Created by Raja Earla on 13/06/18.
//  Copyright © 2018 Raja Earla. All rights reserved.
//

import Foundation

import RxSwift

class APIManager {
    
    private let baseURL = URL(string: "https://api.github.com/")!
    
    func send<T: Codable>(apiRequest: APIRequest) -> Observable<T> {
        return Observable<T>.create { [unowned self] observer in
            let request = apiRequest.request(with: self.baseURL)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else { return }
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [String: AnyObject]{
                        guard let users = json["items"] else {
                            return
                        }
                        let usersData = try JSONSerialization.data(withJSONObject: users, options: .prettyPrinted)
                        let model: T = try JSONDecoder().decode(T.self, from: usersData )
                        observer.onNext(model)
                    }
                } catch let error as NSError {
                    observer.onError(error)
                }
                
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
