//
//  PlatformPickerViewModel.swift
//  ChitChat
//
//  Created by Lau on 10-06-22.
//

import Foundation

extension PlatformPickerView {
    @MainActor class ViewModel: ObservableObject {
        func setPreferredPlatform(preferredPlatform: PreferredPlatform, newPreferredPlatform: SupportedPlatform) {
            preferredPlatform.platform = newPreferredPlatform
            preferredPlatform.savePreferredPlatform(items: preferredPlatform.platform)
        }
    }
}
