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
    @State var dockerFilePath: String = ""
    @State var contextPath: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("Pull Image")
                    .font(.headline)
                TextField("Name of image to pull", text: $imageToPull)
                Button("Pull") {
                    PodService.instance.pullImage(imageName: imageToPull)
                }
            }
            Divider()
            VStack(alignment: .leading) {
                Text("Build Image")
                    .font(.headline)
                TextField("Name of image to build", text: $imageToBuild)
                HStack {
                    TextField("Dockerfile path", text: $dockerFilePath)
                    Button("Browse...") {
                        self.browseFile()
                    }
                }
                HStack {
                    TextField("Context path", text: $contextPath)
                    Button("Browse...") {
                        self.browseDir()
                    }
                }
                Button("Build") {
                    buildImage()
                }
            }
        }
        .padding()
    }
    
    private func browseFile() {
        let dialog = NSOpenPanel()
        dialog.title = "Choose a Docker file"
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            guard let url = dialog.url else {
                return
            }
            dockerFilePath = url.path
            contextPath = url.deletingLastPathComponent().path
        }
    }
    
    private func browseDir() {
        let dialog = NSOpenPanel()
        dialog.title = "Choose a Docker file"
        dialog.canChooseFiles = false
        dialog.canChooseDirectories = true
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            guard let url = dialog.url else {
                return
            }
            contextPath = url.path
        }
    }
    
    private func buildImage() {
        
    }
}

struct OCIImageHeader_Previews: PreviewProvider {
    static var previews: some View {
        OCIImageHeader()
    }
}
