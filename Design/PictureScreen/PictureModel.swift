import Foundation

final class PictureModel {
    
    let service: APIService
    
    init(service: APIService) {
        self.service = service
    }
    
   private func getPicture(query: String, completion: @escaping (APIResponce) -> ()) {
        service.fetchPhotos(query: query) { result in
            if result != nil {
                completion(result!)
            }
        }
    }
}
