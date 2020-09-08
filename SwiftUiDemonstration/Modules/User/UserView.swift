//
//  UserView.swift
//  SwiftUiDemonstration
//
//  Created by  Macbook on 08.09.2020.
//  Copyright © 2020 Golovelv Maxim. All rights reserved.
//

import SwiftUI

struct UserView: View {
    
    @ObservedObject private var userViewModel = UserViewModel()
    
    var userId: Int = 0
    
    var body: some View {
        Text(userViewModel.user?.name ?? "")
            .font(.largeTitle)
            .onAppear {
                self.userViewModel.fetchUser(id: self.userId)
            }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
