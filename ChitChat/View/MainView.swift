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
                            Menu {
                                Picker(selection: $viewModel.selectedPlatformID, label: EmptyView()) {
                                    ForEach(supportedPlatforms) { supportedPlatform in
                                        Text(supportedPlatform.name)
                                    }
                                }
                            } label: {
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
                                .buttonStyle(PlainButtonStyle())
                                .foregroundColor(.accentColor)
                            }
                            .onAppear {
                                viewModel.setSelectedPlatformAsPreferredPlatform(preferredPlatform: preferredPlatform)
                            }
                            .onChange(of: viewModel.selectedPlatformID) { _ in
                                viewModel.setPreferredPlatform(preferredPlatform: preferredPlatform)
                            }
                            
                            TextField("Enter or paste a phone number", text: $viewModel.phoneNumber)
                                .keyboardType(.phonePad)
                        }
                    }
                    
                    Section {
                        if chitChatHistory.chatHistory.count == 0 {
                            VStack(spacing: 17.0) {
                                Image(systemName: "message.fill")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 27.0, height: 27.0, alignment: .center)
                                
                                VStack(spacing: 2.0) {
                                    Text("No Chit Chats")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                    Text("Phone numbers you start chats with will appear here.")
                                        .font(.subheadline)
                                }
                            }
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding()
                        } else {
                            ForEach(chitChatHistory.chatHistory.reversed(), id: \.self) { chatInstance in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(chatInstance.phoneNumber)
                                            .font(.headline)
                                            .fontWeight(.regular)
                                        Text(chatInstance.platform.name)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    Spacer()
                                    HStack(spacing: 6.0) {
                                        Text("\(Calendar.current.component(.hour, from: chatInstance.date)):\(Calendar.current.component(.minute, from: chatInstance.date))")
                                        Button(action: {
                                            print("Info")
                                        }) {
                                            Image(systemName: "info.circle")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 17, height: 17)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                        .foregroundColor(.accentColor)
                                    }
                                }
                                .listRowInsets(EdgeInsets(top: 13.0, leading: 16.0, bottom: 13.0, trailing: 16.0))
                                .transition(.scale)
                            }
                        }
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
                        viewModel.mainButtonAction(preferredPlatform: preferredPlatform, chitChatHistory: chitChatHistory)
                    }) {
                        HStack {
                            Spacer()
                            Text(viewModel.localizedMainButtonLabel(preferredPlatform: preferredPlatform))
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
