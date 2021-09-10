//
//  ImageView.swift
//  PodDesktop
//
//  Created by Luo Sheng on 2021/9/7.
//

import SwiftUI

struct OCIImageView: View {
    
    @ObservedObject var imageStore: ImageStore
    @State var imageToPull: String = ""
    @State var imageToBuild: String = ""
    
    var body: some View {
        VStack {
            List() {
                ForEach(imageStore.images) { image in
                    OCIImageItem(image: image)
                }
            }
            Text("Image Acquistition")
                .font(.title)
            HStack {
                TextField("Name of image to pull", text: $imageToPull)
                Button("Pull Image") {
                    print(imageToPull)
                }
            }
            HStack {
                TextField("Name of image to build", text: $imageToBuild)
                Button("Build Image...") {
                    self.browseFile()
                }
            }
        }
        .onAppear(perform: {
            imageStore.fetch()
        })
        .padding()
    }
    
    private func browseFile() {
        let dialog = NSOpenPanel()
            
        dialog.title                   = "Choose a Docker file"
        dialog.showsResizeIndicator    = true
        dialog.showsHiddenFiles        = false
        dialog.canChooseDirectories    = false
        dialog.canCreateDirectories    = false
        dialog.allowsMultipleSelection = false

        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            let result = dialog.url // Pathname of the file
            if let path = result?.path {
                print("build -f \(path) -t \(imageToBuild)")
            }
        } else {
            return
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        OCIImageView(imageStore: MockModel().imageStore)
    }
}
