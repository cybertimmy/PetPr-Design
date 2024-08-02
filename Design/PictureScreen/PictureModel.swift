import Foundation
import UIKit

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
    
    static func loadImage(from urlString: String ,completion: @escaping(UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                completion(image)
            }
        }
        task.resume()
    }
}
