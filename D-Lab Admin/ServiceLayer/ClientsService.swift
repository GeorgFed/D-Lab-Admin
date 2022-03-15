//
//  AuthService.swift
//  D-Lab Admin
//
//  Created by Egor Fedyaev on 14.03.2022.
//

import Foundation

typealias ClinicsResult = Result<[Clinic], Error>
typealias ClinicsCompletion = (_ result: ClinicsResult) -> Void

typealias DoctorsResult = Result<[Doctor], Error>
typealias DoctorsCompletion = (_ result: DoctorsResult) -> Void

protocol IClientsService {
    func getDoctors(completion: @escaping DoctorsCompletion)
    func getClinics(completion: @escaping ClinicsCompletion)
}

final class ClientsService: IClientsService {
    
    private let mainQ = DispatchQueue.main
    private let globalQ = DispatchQueue.global(qos: .userInitiated)
    
    private let session: IURLSessionManager
    private let userDefaults: IUserDefaultsManager
    private let base: URL
    private let doctorsPath: String
    private let clinicsPath: String
    
    init(base: URL, doctorsPath: String, clinicsPath: String, userDefaults: IUserDefaultsManager, session: IURLSessionManager) {
        self.session = session
        self.userDefaults = userDefaults
        self.base = base
        self.doctorsPath = doctorsPath
        self.clinicsPath = clinicsPath
    }
    
    func getDoctors(completion: @escaping DoctorsCompletion) {
        
        guard let token = userDefaults.get(for: .token) else {
            complete(result: DoctorsResult.failure(AuthError.noBasicAuthToken),
                     queue: mainQ,
                     completion: completion)
            return
        }
        
        let adapter = AuthAdapter(token: token)
        let request =  URLRequestBuilder(with: base, path: doctorsPath).set(method: .GET).add(adapter: adapter).build()
        
        globalQ.async {
            self.session.request(request: request) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let data):
                    self.decode(data: data,
                                completion: completion)
                case .failure(let error):
                    self.complete(result: DoctorsResult.failure(NetworkError.customError(error)),
                                  queue: self.mainQ,
                                  completion: completion)
                }
            }
        }
    }
    
    func getClinics(completion: @escaping ClinicsCompletion) {
        
        guard let token = userDefaults.get(for: .token) else {
            complete(result: ClinicsResult.failure(AuthError.noBasicAuthToken),
                     queue: mainQ,
                     completion: completion)
            return
        }
        
        let adapter = AuthAdapter(token: token)
        let request =  URLRequestBuilder(with: base, path: clinicsPath).set(method: .GET).add(adapter: adapter).build()
        
        globalQ.async {
            self.session.request(request: request) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let data):
                    self.decode(data: data,
                                completion: completion)
                case .failure(let error):
                    self.complete(result: ClinicsResult.failure(NetworkError.customError(error)),
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
    
    func decode(data: Data, completion: @escaping DoctorsCompletion) {
        do {
            let dto = try JSONDecoder().decode([Doctor].self, from: data)
            complete(result: DoctorsResult.success(dto),
                     queue: mainQ,
                     completion: completion)
        } catch {
            complete(result: DoctorsResult.failure(ParseError.customError(error)),
                     queue: mainQ,
                     completion: completion)
        }
    }
    
    func decode(data: Data, completion: @escaping ClinicsCompletion) {
        do {
            let dto = try JSONDecoder().decode([Clinic].self, from: data)
            complete(result: ClinicsResult.success(dto),
                     queue: mainQ,
                     completion: completion)
        } catch {
            complete(result: ClinicsResult.failure(ParseError.customError(error)),
                     queue: mainQ,
                     completion: completion)
        }
    }
}
