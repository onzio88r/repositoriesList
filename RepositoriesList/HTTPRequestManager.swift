//
//  HTTPRequestManager.swift
//  RepositoriesList
//
//  Created by Daniele Rapali on 14/09/2019.
//  Copyright © 2019 Daniele Rapali. All rights reserved.
//

import Foundation


/// Create the URLRequest componene.
/// Default Method : GET
///
/// - Parameter url: url to call
/// - Returns: URLRequest
public func urlRequest(url: URL) -> URLRequest{
    
    /// Http request type
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
    
    return request
}

func requestURLComponent() -> URLComponents {
    var component = URLComponents()
    component.scheme = "https"
    component.host = "api.github.com"
    
    return component
    
}


/// Get the list of repositories for https://api.github.com/users/xing/repos
///
/// - Parameter completion: Return a list of repositories, or error otherwise
func ReposList(completion: ((Result<Repositories,Error>) -> Void)?) {
    
    let session = URLSession.shared
    
    var urlComponent = requestURLComponent()
    urlComponent.path = "/users/xing/repos"
    
    guard let url = urlComponent.url else { fatalError("Could not create URL from components") }
    
    let request = urlRequest(url: url)
    
    let task = session.dataTask(with: request) { data, response, error in
        DispatchQueue.main.sync {
            if error != nil || data == nil {
                print("Client error!")
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Client error!"]) as Error
                completion?(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            
            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.calendar = Calendar(identifier: .iso8601)
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            
            do {
                
                guard let jsonData = data else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
                    completion?(.failure(error))
                    return
                }
                
                let repositoriesList = try decoder.decode([Repository].self, from: jsonData)
                
                let repoDefault = try! JSONEncoder().encode(repositoriesList)
                UserDefaults.standard.setValue(repoDefault, forKey: "RepositoryList")
                
                completion?(.success(repositoriesList))
                
                
            } catch {
                print("JSON error: \(error)")
            }
            
        }
    }
    
    task.resume()
}

func ContributorsList(contributionUrl:String, completion: ((Result<Contributors,Error>) -> Void)?) {
    
    let session = URLSession.shared
    
    var urlComponent = requestURLComponent()
    urlComponent.path = contributionUrl.replacingOccurrences(of: "https://api.github.com", with: "")
    
    guard let url = urlComponent.url else { fatalError("Could not create URL from components") }
    
    let request = urlRequest(url: url)
    
    let task = session.dataTask(with: request) { data, response, error in
        DispatchQueue.main.sync {
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            
            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.calendar = Calendar(identifier: .iso8601)
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            
            do {
                
                guard let jsonData = data else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
                    completion?(.failure(error))
                    return
                }
                
                let contributorsList = try decoder.decode(Contributors.self, from: jsonData)
                
                completion?(.success(contributorsList))
                
                
            } catch {
                print("JSON error: \(error)")
            }
            
        }
    }
    
    task.resume()
}

