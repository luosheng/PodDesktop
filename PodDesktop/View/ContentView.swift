//
//  ContentView.swift
//  PodDesktop
//
//  Created by Luo Sheng on 2021/9/7.
//

import SwiftUI
import AlertToast

struct ContentView: View {
    
    @EnvironmentObject var globalStore: GlobalStore
    
    var body: some View {
        Sidebar()
            .toast(isPresenting: $globalStore.toastState.showToast, duration: 1.0) {
                AlertToast(type: globalStore.toastState.type, title: globalStore.toastState.message)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(GlobalStore())
    }
}
