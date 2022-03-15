import Foundation

typealias DataResult = Result<Data, Error>
typealias DataHandler = (_ result: DataResult) -> Void

protocol IURLSessionManager {
    func request(request: URLRequest, completion: @escaping DataHandler)
}

final class URLSessionManager: IURLSessionManager {
    private let session = URLSession.shared
    private let mainQ = DispatchQueue.main

    func request(request: URLRequest, completion: @escaping DataHandler) {
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }

            if let error = error {
                NSLog("Error \(error)")
                self.complete(on: self.mainQ,
                              result: .failure(NetworkError.customError(error)),
                              completion: completion)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                NSLog("Invalid response")
                self.complete(on: self.mainQ,
                              result: .failure(NetworkError.noResponse),
                              completion: completion)
                return
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                NSLog("HTTP Response invalid code \(httpResponse.statusCode)")
                data?.printJSON()
                self.complete(on: self.mainQ,
                              result: .failure(NetworkError.invalidResponse(httpResponse.statusCode)),
                              completion: completion)
                return
            }

            guard let data = data else {
                NSLog("Invalid data")
                self.complete(on: self.mainQ,
                              result: .failure(NetworkError.invalidResponse(httpResponse.statusCode)),
                              completion: completion)
                return
            }

            self.complete(on: self.mainQ,
                          result: .success(data),
                          completion: completion)
        }
        task.resume()
    }

    private func complete(on queue: DispatchQueue, result: DataResult, completion: @escaping DataHandler) {
        queue.async {
            completion(result)
        }
    }
}
