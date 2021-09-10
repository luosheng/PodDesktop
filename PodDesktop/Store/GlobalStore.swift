//
//  GlobalStore.swift
//  PodDesktop
//
//  Created by Luo Sheng on 2021/9/10.
//

import Foundation
import AlertToast

struct ToastState {
    var showToast: Bool
    var type: AlertToast.AlertType
    var message: String
}

final class GlobalStore: ObservableObject {
    
    @Published var toastState = ToastState(showToast: false, type: .regular, message: "")
}
