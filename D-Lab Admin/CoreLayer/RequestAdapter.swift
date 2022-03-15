import Foundation

protocol RequestAdapter {
    func adapt(_ urlRequest: URLRequest) -> URLRequest
}

class AuthAdapter: RequestAdapter {
    private let token: String
    
    init(token: String) {
        self.token = token
    }
    
    func adapt(_ urlRequest: URLRequest) -> URLRequest {
        var urlRequest = urlRequest
        urlRequest.addValue("Token \(token)", forHTTPHeaderField: "Authorization")
        return urlRequest
    }
}
