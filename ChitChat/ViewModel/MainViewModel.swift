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
        @Published var selectedPlatformID: String = supportedPlatforms[0].id
        
        func localizedMainButtonLabel(preferredPlatform: PreferredPlatform) -> String {
            if self.phoneNumber.isEmpty {
                return "Paste"
            } else {
                return "Start Chat in \(preferredPlatform.platform.name)"
            }
        }
        
        func mainButtonAction(preferredPlatform: PreferredPlatform, chitChatHistory: ChitChatHistory) {
            if self.phoneNumber.isEmpty {
                let pasteboard = UIPasteboard.general
                if let string = pasteboard.string {
                    self.phoneNumber = string
                } else {
                    print("No string was found in pasteboard")
                }
            } else {
                let formattedPhoneNumber: String = "+\(self.phoneNumber.filter("0123456789".contains))"
                if formattedPhoneNumber.isEmpty {
                    print("Not a phone number")
                    DispatchQueue.main.async {
                        // Haptic feedback <3
                        let feedback = UINotificationFeedbackGenerator()
                        feedback.notificationOccurred(.error)
                    }
                } else {
                    if let url = URL(string: "\(preferredPlatform.platform.urlPrefix)\(formattedPhoneNumber)") {
                        // Save to Chit Chat History
                        let newChatInstance = ChatInstance(phoneNumber: formattedPhoneNumber, date: Date(), platform: preferredPlatform.platform)
                        
                        withAnimation {
                            chitChatHistory.chatHistory.append(newChatInstance)
                            chitChatHistory.saveToChatHistory(items: chitChatHistory.chatHistory)
                        }
                        
                        // Open in App
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            UIApplication.shared.open(url)
                        }
                    }
                }
            }
        }
        
        func setSelectedPlatformAsPreferredPlatform(preferredPlatform: PreferredPlatform) {
            self.selectedPlatformID = preferredPlatform.platform.id
        }
        
        func setPreferredPlatform(preferredPlatform: PreferredPlatform) {
            preferredPlatform.platform = supportedPlatforms.first(where: { $0.id == self.selectedPlatformID })!
            preferredPlatform.savePreferredPlatform(items: preferredPlatform.platform)
        }
    }
}
