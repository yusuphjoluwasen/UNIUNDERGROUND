//
//  AppStateView.swift
//  UniUnderground
//
//  Created by Guru King on 12/05/2023.
//

import SwiftUI

struct AppStateView: View {
    @EnvironmentObject var vm: AppStateViewModel
    
    var body: some View {
        if (vm.isLoggedIn) {
            ProfileView()
        } else {
            SelectSchool()
        }
    }
}

struct AppStateView_Previews: PreviewProvider {
    static var previews: some View {
        AppStateView()
    }
}
