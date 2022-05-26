//
//  NetworkManager.swift
//  BestAppStoreApps
//
//  Created by Guy Twig on 24/04/2022.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    let baseUrl = "https://rss.applemarketingtools.com"
    
    func getFreeApps(callBack: @escaping (Bool, [Results]?) -> Void) {
        
        let freeAppsEndPoint = "/api/v2/us/apps/top-free/10/apps.json"
        let freeAppsApi = baseUrl + freeAppsEndPoint
        
        guard let url = URL(string: freeAppsApi) else {
            print("Failed load Free Apps List")
            return callBack(false, nil)
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Failed load Free Apps List")
                return callBack(false, nil)
            }
            do {
                let response = try JSONDecoder().decode(ResponseFreeApps.self, from: data)
                callBack(true, response.feed.results)
            } catch {
                print("Failed load Free Apps List")
                callBack(false, nil)
            }
        }
        task.resume()
    }
    
    func getPaidApps(callBack: @escaping (Bool, [Results]?) -> Void) {
        
        let PaidAppsEndPoint = "/api/v2/us/apps/top-paid/25/apps.json"
        let PaidAppsApi = baseUrl + PaidAppsEndPoint
        
        guard let url = URL(string: PaidAppsApi) else {
            print("Failed load paid Apps List")
            return callBack(false, nil)
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Failed load paid Apps List")
                return callBack(false, nil)
            }
            do {
                let response = try JSONDecoder().decode(ResponsePaidApps.self, from: data)
                callBack(true, response.feed.results)
            } catch {
                print("Failed load paid Apps List")
                callBack(false, nil)
            }
        }
        task.resume()
    }
    
    func getAlmoFirePaidApps(callBack: @escaping (Bool, [ResultCoreData]?) -> Void) {

        let freeAppsEndPoint = "/api/v2/us/apps/top-free/10/apps.json"
        let freeAppsApi = baseUrl + freeAppsEndPoint

        


        guard let url = URL(string: freeAppsApi) else {
            print("Failed load Free Apps List")
            return callBack(false, nil)
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Failed load Free Apps List")
                return callBack(false, nil)
            }
            do {
                let response = try JSONDecoder().decode(ResponsePaidAppsCoreData.self, from: data)
                callBack(true, response.feedCoreData?.resultCoreData)
            } catch {
                print("Failed load Free Apps List")
                callBack(false, nil)
            }
        }
        task.resume()
    }
}
