//
//  AuthService.swift
//  D-Lab Admin
//
//  Created by Egor Fedyaev on 14.03.2022.
//

import Foundation

typealias AuthResult = Result<AuthResponse, Error>
typealias AuthCompletion = (_ result: AuthResult) -> Void

protocol IAuthService {
    func authorize(user creds: UserCreds, completion: @escaping EmptyCompletion)
}

final class AuthService: IAuthService {
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
    
    func authorize(user creds: UserCreds, completion: @escaping EmptyCompletion) {
        post(body: creds) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                // MARK: TODO USE KEYCHAIN!!
                self.userDefaults.set(key: .isSignedIn, value: true)
                self.userDefaults.set(key: .token, value: response.token)
                print(response.token) // MARK: TODO REMOVE
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func post(body: UserCreds, completion: @escaping AuthCompletion) {
        do {
            let bodyJSON = try JSONEncoder().encode(body)
            let header = ["Content-Type":"application/json; charset=utf-8"]
            let request =  URLRequestBuilder(with: base, path: path).set(method: .POST).set(body: bodyJSON).set(headers: header).build()
            
            globalQ.async {
                self.session.request(request: request) { [weak self] result in
                    guard let self = self else { return }
                    
                    switch result {
                    case .success(let data):
                        self.decode(data: data,
                                    completion: completion)
                    case .failure(let error):
                        self.complete(result: AuthResult.failure(NetworkError.customError(error)),
                                      queue: self.mainQ,
                                      completion: completion)
                    }
                }
            }
        } catch let error {
            self.complete(result: AuthResult.failure(ParseError.customError(error)),
                          queue: self.mainQ,
                          completion: completion)
        }
    }
    
    func complete<T>(result: T, queue: DispatchQueue, completion: @escaping (T) -> Void) {
        queue.async {
            completion(result)
        }
    }
    
    func decode(data: Data, completion: @escaping AuthCompletion) {
        do {
            let dto = try JSONDecoder().decode(AuthResponse.self, from: data)
            complete(result: AuthResult.success(dto),
                     queue: mainQ,
                     completion: completion)
        } catch {
            complete(result: AuthResult.failure(ParseError.customError(error)),
                     queue: mainQ,
                     completion: completion)
        }
    }
}
