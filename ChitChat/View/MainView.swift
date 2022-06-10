//
//  MainView.swift
//  ChitChat
//
//  Created by Lau on 10-06-22.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = ViewModel()
    @StateObject private var preferredPlatform = PreferredPlatform()
    @StateObject private var chitChatHistory = ChitChatHistory()
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    Section {
                        HStack(spacing: 14.0) {
                            Button(action: {
                                print("Choose App")
                            }) {
                                HStack(spacing: 6.0) {
                                    Image(preferredPlatform.platform.iconArtworkName)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 29, height: 29, alignment: .center)
                                        .clipShape(RoundedRectangle(cornerRadius: 7.0, style: .continuous))
                                    Image(systemName: "chevron.down")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 15, height: 15)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                            .foregroundColor(.accentColor)
                            
                            TextField("Enter or paste a phone number", text: $viewModel.phoneNumber)
                                .keyboardType(.phonePad)
                                .textContentType(.telephoneNumber)
                        }
                    }
                    Section {
                        Text("No recents.")
                    } header: {
                        Text("Recents")
                    }
                }
                .navigationTitle("Chit Chat")
            }
            
            VStack {
                Spacer()
                
                VStack {
                    Button(action: {
                        print("Paste or Start Chat")
                    }) {
                        HStack {
                            Spacer()
                            Text(viewModel.localizedButtonLabel(preferredPlatform: preferredPlatform))
                            Spacer()
                        }
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.accentColor)
                    .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                }
                .padding()
                .background(.thinMaterial)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
