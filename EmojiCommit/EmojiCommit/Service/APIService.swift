//
//  APIService.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/04/06.
//

import Foundation
import Combine

protocol APIRequestType {
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
}

protocol APIServiceType {
    func response<Request>(from request: Request) -> AnyPublisher<Data, APIServiceError>? where Request: APIRequestType
}

final class APIService: APIServiceType {
    private let baseURL: URL?
    
    init(baseURL: URL? = URL(string: "https://github.com")) {
        self.baseURL = baseURL
    }
    
    func response<Request>(from request: Request) -> AnyPublisher<Data, APIServiceError>? where Request : APIRequestType {
        
        guard let encodedPath = request.path.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
            let pathURL = URL(string: encodedPath, relativeTo: self.baseURL) else {
            return nil
        }
        
        var urlComponents = URLComponents(url: pathURL, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = request.queryItems
        
        guard let requestURL = urlComponents?.url else {
            return nil
        }
        
        var request = URLRequest(url: requestURL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let result = URLSession.shared.dataTaskPublisher(for: request)
            .tryMap() { element -> Data in
                if let httpResponse = element.response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    switch HttpStatusCode(rawValue: statusCode) {
                    case .success:
                        break
                    case .notFoundError:
                        throw APIServiceError.clientError
                    case .internalServerError:
                        throw APIServiceError.serverError
                    default:
                        break
                    }
                }
                return element.data
            }
            .mapError({ error -> APIServiceError in
                switch error {
                case let error as APIServiceError:
                    return error
                case let error as NSError:
                    if URLError.Code(rawValue: error.code) == .notConnectedToInternet {
                        return APIServiceError.internetError
                    } else {
                        return APIServiceError.unknowError(error.localizedDescription)
                    }
                }
            })
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        
        return result
    }
}

