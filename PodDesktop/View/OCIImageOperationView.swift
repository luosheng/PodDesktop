//
//  OCIImageHeader.swift
//  PodDesktop
//
//  Created by Luo Sheng on 2021/9/10.
//

import SwiftUI

struct OCIImageOperationView: View {
    
    @State var imageToPull: String = ""
    @State var imageToBuild: String = ""
    @State var dockerFilePath: String = ""
    @State var contextPath: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Pull Image")
                        .font(.headline)
            ) {
                TextField("Name of image to pull", text: $imageToPull)
                Button("Pull") {
                    PodService.instance.pullImage(imageName: imageToPull)
                }
            }
            Divider()
            Section(header: Text("Build Image")
                        .font(.headline)
            ) {
                TextField("Name of image to build", text: $imageToBuild)
                HStack {
                    TextField("Dockerfile path", text: $dockerFilePath)
                    Button("...") {
                        self.browseFile()
                    }
                }
                HStack {
                    TextField("Context path", text: $contextPath)
                    Button("...") {
                        self.browseDir()
                    }
                }
                Button("Build") {
                    buildImage()
                }
            }
            Spacer()
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
        OCIImageOperationView()
    }
}
