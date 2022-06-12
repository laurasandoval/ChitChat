//
//  ChatInstance.swift
//  ChitChat
//
//  Created by Lau on 10-06-22.
//

import Foundation

struct ChatInstance: Codable, Hashable, Identifiable {
    var id = UUID()
    var phoneNumber: String
    var date: Date
    var platform: SupportedPlatform
}
