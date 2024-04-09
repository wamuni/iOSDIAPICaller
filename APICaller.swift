//
//  APICaller.swift
//  APIKit
//
//  Created by 潘博石 on 09/04/2024.
//

import Foundation

public class APICaller {
    static let shared = APICaller()
    
    public func fetchCoursesName(completion: @escaping (([String]) -> Void)) {
        
        guard let url = URL(string: "https://iosacademy.io/api/v1/courses/index.php") else {
            completion([])
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion([])
                return
            }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [[String: String]] else {
                    completion([])
                    return
                }
                
                let names = json.compactMap({$0["name"]})
                completion(names)
                
            } catch {
                completion([])
            }
            
        }
        
        task.resume()
    }
}
