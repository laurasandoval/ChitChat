//
//  PreferredPlatform.swift
//  ChitChat
//
//  Created by Lau on 10-06-22.
//

import Foundation

@MainActor class PreferredPlatform: ObservableObject {
    @Published var platform: SupportedPlatform = {
        do {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let fileURL = paths[0].appendingPathComponent("preferredPlatform.json")
            
            let data = try Data(contentsOf: fileURL)
            let items = try JSONDecoder().decode(SupportedPlatform.self, from: data)
            
            return items
        } catch {
            print(error.localizedDescription)
            return SupportedPlatforms[0]
        }
    }()
    
    func savePreferredPlatform(items: SupportedPlatform) {
        do {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let fileURL = paths[0].appendingPathComponent("preferredPlatform.json")
            
            try JSONEncoder().encode(platform).write(to: fileURL)
        } catch {
            print(error.localizedDescription)
        }
    }
}
