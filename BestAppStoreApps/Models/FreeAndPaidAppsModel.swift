//
//  FreeAndPaidAppsModel.swift
//  BestAppStoreApps
//
//  Created by Guy Twig on 24/04/2022.
//

import Foundation

struct ResponseFreeApps: Codable {
    var feed: Feed
}

struct ResponsePaidApps: Decodable {
    var feed: Feed
}

struct Feed: Codable {
    let results: [Results]?
}

struct Results: Codable {
    let name: String
    let artworkUrl100: String
    let url: String
}
