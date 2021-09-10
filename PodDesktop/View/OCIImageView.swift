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
        List() {
            VStack(alignment: .leading) {
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
            .padding()
            .background(Color(red: 237.0 / 255.0, green: 242.0 / 255.0, blue: 247.0 / 255.0))
            ForEach(imageStore.images) { image in
                OCIImageItem(image: image)
            }
        }
        .onAppear(perform: {
            imageStore.fetch()
        })
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
