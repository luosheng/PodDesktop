//
//  OCIImageItem.swift
//  PodDesktop
//
//  Created by Luo Sheng on 2021/9/10.
//

import SwiftUI
import AlertToast

struct OCIImageItem: View {
    
    var image: OCIImage
    @State private var hovering = false
    
    @EnvironmentObject private var globalStore: GlobalStore
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(image.repositoryWithTag)
                        .font(.headline)
                    Text(image.id)
                }
                HStack {
                    Text(image.createdSince)
                    Text(image.size)
                }
            }
            
            Spacer()
            
            HStack {
                Button(action: {
                    NSPasteboard.general.clearContents()
                    NSPasteboard.general.setString(image.id, forType: .string)
                    
                    globalStore.toastState = ToastState(showToast: true, type: .complete(.green), message: "Image id \(image.id) copied")
                }) {
                    Image(systemSymbol: .paperclipCircle)
                        .resizable()
                        .foregroundColor(.accentColor)
                }
                .buttonStyle(PlainButtonStyle())
                .frame(width: 24, height: 24)
                
                Button(action: {
                    PodService.instance.removeImage(image: image)
                }) {
                    Image(systemSymbol: .trashCircle)
                        .resizable()
                        .foregroundColor(.accentColor)
                }
                .buttonStyle(PlainButtonStyle())
                .frame(width: 24, height: 24)
            }
            .opacity(hovering ? 1.0 : 0.0)
        }
        .onHover(perform: { hovering in
            self.hovering = hovering
        })
    }
}

struct OCIImageItem_Previews: PreviewProvider {
    static var previews: some View {
        OCIImageItem(image: MockModel().imageStore.images[0])
            .environmentObject(GlobalStore())
    }
}
