import Foundation

final class Constants {
    
    static let clintId = "xAZ1YDLBy9RSRrcDfj6kaULtG-a9gXyWAet3vzPFprg"
}

final class APIService {
    
    private func getDataFromUrl<T: Codable>(_ urlRequest: URLRequest, parseModel: T.Type, completion: @escaping (T?) -> ()) {
        _ = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(result)
            }
            catch {
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    public func fetchPhotos(query: String, completion: @escaping (APIResponce?) -> ()) {
        let urlString = "https://api.unsplash.com/search/photos?page=1&query=\(query)&client_id=\(Constants.clintId)"
        guard let url = URL(string: urlString) else {
            return
        }
        let request = URLRequest(url: url)
        getDataFromUrl(request, parseModel: APIResponce.self) { result in
            completion(result)
        }
    }
}
