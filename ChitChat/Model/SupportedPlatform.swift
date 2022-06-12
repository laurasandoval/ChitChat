//
//  SupportedPlatform.swift
//  ChitChat
//
//  Created by Lau on 10-06-22.
//

import Foundation

struct SupportedPlatform: Codable, Hashable, Identifiable {
    var id: String
    var name: String
    var iconArtworkName: String
    var urlPrefix: String
}
