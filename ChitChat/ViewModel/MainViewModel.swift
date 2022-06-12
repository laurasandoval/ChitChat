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
        
        func mainButtonAction(preferredPlatform: PreferredPlatform) {
            if self.phoneNumber.isEmpty {
                let pasteboard = UIPasteboard.general
                if let string = pasteboard.string {
                    self.phoneNumber = string
                } else {
                    print("No string was found in pasteboard")
                }
            } else {
                let formattedPhoneNumber = self.phoneNumber.filter("0123456789.".contains)
                if let url = URL(string: "\(preferredPlatform.platform.urlPrefix)+\(formattedPhoneNumber)") {
                    UIApplication.shared.open(url)
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
