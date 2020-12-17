//
//  PostService.swift
//  Reign Test
//
//  Created by Martin Regas on 14/10/2020.
//

import UIKit
import Alamofire

class PostService: ServiceProtocol {
    func getPosts(completionHandler: @escaping ([Post]?, URLError?) -> ()) {

        AF.request(Endpoints.URL).responseJSON(completionHandler: {
            response in

            print(response)
            
            if let error = response.error {
                if let underlyingError = error.underlyingError {
                    if let urlError = underlyingError as? URLError {
                        completionHandler(nil, urlError)
                        return
                    }
                }
            }
            
            guard let data = response.data else {
                return
            }

            let decoder = JSONDecoder()
            if let dataStore = try? decoder.decode(PostsDataStore.self, from: data) {
                print("Decoded : \(dataStore)")
                completionHandler(dataStore.posts, nil)
            }

        })
    }
}
