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

struct OCIImageHeader_Previews: PreviewProvider {
    static var previews: some View {
        OCIImageHeader()
    }
}
