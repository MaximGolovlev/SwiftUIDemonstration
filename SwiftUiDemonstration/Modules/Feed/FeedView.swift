//
//  UserView.swift
//  SwiftUiDemonstration
//
//  Created by  Macbook on 08.09.2020.
//  Copyright © 2020 Golovelv Maxim. All rights reserved.
//

import SwiftUI


struct FeedView: View {
    
    @ObservedObject private var feedViewModel = FeedViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(feedViewModel.users, id: \.self) { user in
                    NavigationLink(destination: UserView(userId: user.id)) {
                        UserRow(name: user.name)
                    }
                }
            }
            .environment(\.defaultMinListRowHeight, 60)
            .navigationBarTitle(Text("Feed"))
        }.onAppear {
            self.feedViewModel.fetchUsers()
        }
    }
}

struct UserRow: View {
    
    var name: String
    
    var body: some View {
        HStack {
            Image("man")
                .resizable()
                .frame(width: 32.0, height: 32.0)
                .cornerRadius(32.0)
            Text(name)
                .font(.caption)
                .foregroundColor(.green)
        }
        
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
