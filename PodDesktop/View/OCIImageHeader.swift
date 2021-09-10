//
//  OCIImageHeader.swift
//  PodDesktop
//
//  Created by Luo Sheng on 2021/9/10.
//

import SwiftUI

struct OCIImageHeader: View {
    
    @State var imageToPull: String = ""
    @State var imageToBuild: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Image Acquistition")
                .font(.title)
            HStack {
                TextField("Name of image to pull", text: $imageToPull)
                Button("Pull Image") {
                    PodService.instance.pullImage(imageName: imageToPull)
                }
            }
            HStack {
                TextField("Name of image to build", text: $imageToBuild)
                Button("Build Image...") {
                    self.browseFile()
                }
            }
        }
        .padding()
        .background(Color(red: 237.0 / 255.0, green: 242.0 / 255.0, blue: 247.0 / 255.0))
    }
    
    private func browseFile() {
        let fileDialog = NSOpenPanel()
        fileDialog.title = "Choose a Docker file"
        if (fileDialog.runModal() == NSApplication.ModalResponse.OK) {
            let ctxDialog = NSOpenPanel()
            ctxDialog.canChooseFiles = false
            ctxDialog.canChooseDirectories = true
            ctxDialog.title = "Choose context path"
            if (ctxDialog.runModal() == NSApplication.ModalResponse.OK) {
                guard let fileUrl = fileDialog.url,
                      let contextUrl = ctxDialog.url else {
                    return
                }
                PodService.instance.buildImage(fileUrl: fileUrl, contextUrl: contextUrl, tag: imageToBuild)
            }
        }
//
//        let dialog = NSOpenPanel()
//
//        dialog.title = "Choose a Docker file"
//        dialog.showsResizeIndicator = true
//        dialog.showsHiddenFiles = false
//        dialog.canChooseDirectories = false
//        dialog.canCreateDirectories = false
//        dialog.allowsMultipleSelection = false
//
//        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
//            let result = dialog.url
//            if let path = result?.path {
//
//            }
//        } else {
//            return
//        }
    }
}

struct OCIImageHeader_Previews: PreviewProvider {
    static var previews: some View {
        OCIImageHeader()
    }
}
