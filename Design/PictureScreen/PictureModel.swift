//
//  PictureModel.swift
//  Minimalism Productive
//
//  Created by Boris Dobretsov on 28/6/24.
//

import Foundation

class PictureModel {
    
    let service: APIService
    
    init(service: APIService) {
        self.service = service
    }
    
    func getPicture(query: String, completion: @escaping (APIResponce) -> ()) {
        service.fetchPhotos(query: query) { result in
            if result != nil {
                completion(result!)
            }
        }
    }
}
