//
//  ContentView.swift
//  ChitChat
//
//  Created by Lau on 10-06-22.
//

import SwiftUI

struct ContentView: View {
    @State private var phoneNumber: String = ""
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack {
                        Button(action: {
                            print("Choose App")
                        }) {
                            HStack {
                                Image("WhatsApp")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 29, height: 29, alignment: .center)
                                    .clipShape(RoundedRectangle(cornerRadius: 7.0, style: .continuous))
                                Image(systemName: "chevron.down")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 18, height: 18)
                            }
                        }
                        
                        TextField("Enter or paste a phone number", text: $phoneNumber)
                    }
                }
                Section {
                    
                } header: {
                    Text("Recents")
                }
            }
            .navigationTitle("Chit Chat")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
