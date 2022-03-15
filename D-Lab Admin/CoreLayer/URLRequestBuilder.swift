import Foundation

enum HTTPMethod: String {
    case POST, PUT, DELETE, UPDATE, GET, PATCH
}

class URLRequestBuilder {

    var baseURL: URL
    var path: String
    var method: HTTPMethod = .GET
    var headers: [String: String]?
    var parameters: [String: String?]?
    var adapters: [RequestAdapter] = []
    var httpBody: Data?
    var queryItems: [URLQueryItem]?

    init(with baseURL: URL, path: String) {
        self.baseURL = baseURL
        self.path = path
    }

    @discardableResult
    func add(adapter: RequestAdapter?) -> URLRequestBuilder {
        guard let adapter = adapter else { return self }
        adapters.append(adapter)
        return self
    }

    @discardableResult
    func set(method: HTTPMethod) -> Self {
        self.method = method
        return self
    }

    @discardableResult
    func set(path: String) -> Self {
        self.path = path
        return self
    }

    @discardableResult
    func set(headers: [String: String]?) -> Self {
        self.headers = headers
        return self
    }

    @discardableResult
    func set(parameters: [String: String]?) -> Self {
        self.parameters = parameters
        return self
    }

    @discardableResult
    func set(body: Data) -> Self {
        self.httpBody = body
        return self
    }

    func set(queryItems: [URLQueryItem]) -> Self {
        self.queryItems = queryItems
        return self
    }

    func build() -> URLRequest {
        var url = baseURL.appendingPathComponent(path).appending(parameters: parameters)

        if let queryItems = queryItems {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            components?.queryItems = queryItems
            if let queryItemsUrl = components?.url {
                url = queryItemsUrl
            }
        }

        var urlRequest = URLRequest(url: url,
                                    cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                    timeoutInterval: 100)
        urlRequest.httpMethod = method.rawValue

        headers?.forEach {
            urlRequest.addValue($0.value, forHTTPHeaderField: $0.key)
        }

        adapters.forEach {
            urlRequest = $0.adapt(urlRequest)
        }

        if let body = httpBody {
            urlRequest.httpBody = body
        }

        return urlRequest
    }

    func build<T: Codable>(with body: T) throws -> URLRequest {
        let urlRequest = build()
        do {
            return try buildRequestParams(urlRequest, body: body)
        } catch {
            throw NetworkError.customError(error)
        }
    }

    fileprivate func buildRequestParams<T: Codable>(_ urlRequest: URLRequest, body: T) throws -> URLRequest {
        var urlRequest = urlRequest
        let encoder = JSONEncoder()
        let jsonData = try encoder.encode(body)
        urlRequest.httpBody = jsonData
        return urlRequest
    }
}
