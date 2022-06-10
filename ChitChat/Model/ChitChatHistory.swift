//
//  ChitChatHistory.swift
//  ChitChat
//
//  Created by Lau on 10-06-22.
//

import Foundation

@MainActor class ChitChatHistory: ObservableObject {
    @Published var chatHistory: [ChatInstance] = {
        do {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let fileURL = paths[0].appendingPathComponent("chitChatHistory.json")
            
            let data = try Data(contentsOf: fileURL)
            let items = try JSONDecoder().decode([ChatInstance].self, from: data)
            
            return items
        } catch {
            print(error.localizedDescription)
            return []
        }
    }()
    
    func saveToChatHistory(items: [ChatInstance]) {
        do {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let fileURL = paths[0].appendingPathComponent("chitChatHistory.json")
            
            try JSONEncoder().encode(chatHistory).write(to: fileURL)
        } catch {
            print(error.localizedDescription)
        }
    }
}
