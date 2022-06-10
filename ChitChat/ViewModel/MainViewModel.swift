//
//  MainViewModel.swift
//  ChitChat
//
//  Created by Lau on 10-06-22.
//

import Foundation
import SwiftUI

extension MainView {
    @MainActor class ViewModel: ObservableObject {
        @Published var phoneNumber: String = ""
        
        func localizedButtonLabel(preferredPlatform: PreferredPlatform) -> String {
            if self.phoneNumber.isEmpty {
                return "Paste"
            } else {
                return "Start Chat in \(preferredPlatform.platform.name)"
            }
        }
    }
}
