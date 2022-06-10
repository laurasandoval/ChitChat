//
//  PlatformPickerView.swift
//  ChitChat
//
//  Created by Lau on 10-06-22.
//

import SwiftUI

struct PlatformPickerView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var preferredPlatform: PreferredPlatform
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(SupportedPlatforms, id: \.self.name) { supportedPlatform in
                        Button(action: {
                            viewModel.setPreferredPlatform(preferredPlatform: preferredPlatform, newPreferredPlatform: supportedPlatform)
                        }) {
                            HStack(spacing: 14.0) {
                                Image(supportedPlatform.iconArtworkName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50, alignment: .center)
                                    .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                                
                                Text(supportedPlatform.name)
                                    .foregroundColor(.primary)
                                
                                Spacer()
                                
                                if preferredPlatform.platform == supportedPlatform {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.accentColor)
                                }
                            }
                            .padding(7.0)
                            .padding(.leading, 0.0)
                        }
                    }
                }
            }
            .onChange(of: preferredPlatform.platform, perform: { newPreferredPlatform in
                dismiss()
            })
            .navigationTitle("Send to")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Done")
                    }
                }
            }
        }
    }
}

struct PlatformPickerView_Previews: PreviewProvider {
    static var previews: some View {
        PlatformPickerView()
    }
}
