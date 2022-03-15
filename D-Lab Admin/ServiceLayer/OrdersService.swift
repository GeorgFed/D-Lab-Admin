//
//  AuthService.swift
//  D-Lab Admin
//
//  Created by Egor Fedyaev on 14.03.2022.
//

import Foundation

typealias OrdersResult = Result<[Order], Error>
typealias OrdersCompletion = (_ result: OrdersResult) -> Void

protocol IOrdersService {
    func get(completion: @escaping OrdersCompletion)
}

final class OrdersService: IOrdersService {
    
    private let mainQ = DispatchQueue.main
    private let globalQ = DispatchQueue.global(qos: .userInitiated)
    
    private let session: IURLSessionManager
    private let userDefaults: IUserDefaultsManager
    private let base: URL
    private let path: String
    
    init(base: URL, path: String, userDefaults: IUserDefaultsManager, session: IURLSessionManager) {
        self.session = session
        self.userDefaults = userDefaults
        self.base = base
        self.path = path
    }
    
    func get(completion: @escaping OrdersCompletion) {
        
        guard let token = userDefaults.get(for: .token) else {
            complete(result: OrdersResult.failure(AuthError.noBasicAuthToken),
                     queue: mainQ,
                     completion: completion)
            return
        }
        
        let adapter = AuthAdapter(token: token)
        let request =  URLRequestBuilder(with: base, path: path).set(method: .GET).add(adapter: adapter).build()
        
        globalQ.async {
            self.session.request(request: request) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let data):
                    self.decode(data: data,
                                completion: completion)
                case .failure(let error):
                    self.complete(result: OrdersResult.failure(NetworkError.customError(error)),
                                  queue: self.mainQ,
                                  completion: completion)
                }
            }
        }
    }
    
    func complete<T>(result: T, queue: DispatchQueue, completion: @escaping (T) -> Void) {
        queue.async {
            completion(result)
        }
    }
    
    func decode(data: Data, completion: @escaping OrdersCompletion) {
        do {
            let dto = try JSONDecoder().decode([Order].self, from: data)
            complete(result: OrdersResult.success(dto),
                     queue: mainQ,
                     completion: completion)
        } catch {
            complete(result: OrdersResult.failure(ParseError.customError(error)),
                     queue: mainQ,
                     completion: completion)
        }
    }
}
