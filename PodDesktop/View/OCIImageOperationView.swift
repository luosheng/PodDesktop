//
//  OCIImageHeader.swift
//  PodDesktop
//
//  Created by Luo Sheng on 2021/9/10.
//

import SwiftUI
import SFSafeSymbols

struct OCIImageOperationView: View {
    
    @State var imageToPull: String = ""
    @State var imageToBuild: String = ""
    @State var dockerFilePath: String = ""
    @State var contextPath: String = ""
    @State var dockerImagePath: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Pull Image")
                        .font(.headline)
            ) {
                TextField("Name of image to pull", text: $imageToPull)
                Button(action: {
                    PodService.instance.pullImage(imageName: imageToPull)
                }) {
                    Image(systemSymbol: .arrowTrianglePull)
                    Text("Pull")
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
                        self.browse({ dialog in
                            dialog.title = "Choose a Docker file"
                        }) { url in
                            dockerFilePath = url.path
                            contextPath = url.deletingLastPathComponent().path
                        }
                    }
                }
                HStack {
                    TextField("Context path", text: $contextPath)
                    Button("...") {
                        self.browse({ dialog in
                            dialog.title = "Choose context path"
                            dialog.canChooseFiles = false
                            dialog.canChooseDirectories = true
                        }) { url in
                            contextPath = url.path
                        }
                    }
                }
                Button(action: {
                    buildImage()
                }) {
                    Image(systemSymbol: .hammer)
                    Text("Build")
                }
            }
            Divider()
            Section(header: Text("Load Image")
                        .font(.headline)
            ) {
                HStack {
                    TextField("Docker image archive path", text: $dockerImagePath)
                    Button("...") {
                        self.browse({ dialog in
                            dialog.title = "Choose context path"
                            dialog.allowedFileTypes = ["tar", "zip"]
                        }) { url in
                            dockerImagePath = url.path
                        }
                    }
                }
                Button(action: {
                    buildImage()
                }) {
                    Image(systemSymbol: .squareAndArrowDown)
                    Text("Load")
                }
            }
            Spacer()
        }
        .padding()
    }
    
    private func browse(_ config: ((NSOpenPanel) -> Void)?, completion: (URL) -> Void) {
        let dialog = NSOpenPanel()
        if let config = config {
            config(dialog)
        }
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            guard let url = dialog.url else {
                return
            }
            completion(url)
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
