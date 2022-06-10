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
        @Published var showingPlatformPickerView: Bool = false
        
        func localizedMainButtonLabel(preferredPlatform: PreferredPlatform) -> String {
            if self.phoneNumber.isEmpty {
                return "Paste"
            } else {
                return "Start Chat in \(preferredPlatform.platform.name)"
            }
        }
        
        func mainButtonAction(preferredPlatform: PreferredPlatform) {
            if self.phoneNumber.isEmpty {
                let pasteboard = UIPasteboard.general
                if let string = pasteboard.string {
                    self.phoneNumber = string
                } else {
                    print("No string was found in pasteboard")
                }
            } else {
                if let url = URL(string: "\(preferredPlatform.platform.urlPrefix)\(self.phoneNumber)") {
                    UIApplication.shared.open(url)
                }
            }
        }
    }
}
