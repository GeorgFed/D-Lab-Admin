//
//  AuthService.swift
//  D-Lab Admin
//
//  Created by Egor Fedyaev on 14.03.2022.
//

import Foundation

typealias PaymentsResult = Result<[Payment], Error>
typealias PaymentsCompletion = (_ result: PaymentsResult) -> Void

protocol IPaymentsService {
    func get(completion: @escaping PaymentsCompletion)
}

final class PaymentsService: IPaymentsService {
    
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
    
    func get(completion: @escaping PaymentsCompletion) {
        
        guard let token = userDefaults.get(for: .token) else {
            complete(result: PaymentsResult.failure(AuthError.noBasicAuthToken),
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
                    self.complete(result: PaymentsResult.failure(NetworkError.customError(error)),
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
    
    func decode(data: Data, completion: @escaping PaymentsCompletion) {
        do {
            let dto = try JSONDecoder().decode([Payment].self, from: data)
            complete(result: PaymentsResult.success(dto),
                     queue: mainQ,
                     completion: completion)
        } catch {
            complete(result: PaymentsResult.failure(ParseError.customError(error)),
                     queue: mainQ,
                     completion: completion)
        }
    }
}
