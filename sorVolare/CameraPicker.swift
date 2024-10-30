//
//  CameraPicker.swift
//  sorVolare
//
//  Created by Fabrizio Petrellese on 30/10/24.
//

import SwiftUI

// Camera Picker veniva richiamato in questo modo da una ContentView, in questo esempio c'è un semplice bottone
// e quando ci clicchi sopra si apre la camera

/*
 @State private var showCamera = false
 @State private var image = UIImage()

 var body: some View {
     VStack {

         Image(uiImage: image)
             .resizable()
             .scaledToFit()
             .frame(width: 1 * UIScreen.main.bounds.width, height: 0.7 * UIScreen.main.bounds.height)
             .edgesIgnoringSafeArea(.all)
         
         Button {
             showCamera = true
         } label: {
             Text("Camera Picker")
             .font(.title2)
             .padding()
         }
     }
     .fullScreenCover(isPresented: $showCamera) {
         CameraPicker(sourceType: .camera, selectedImage: $image)
             .ignoresSafeArea()
     }
 }
 */


struct CameraPicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    var sourceType: UIImagePickerController.SourceType = .camera
    @Binding var selectedImage: UIImage

    func makeUIViewController(context: UIViewControllerRepresentableContext<CameraPicker>) -> UIImagePickerController {
        
        let cameraPicker = UIImagePickerController()
        cameraPicker.allowsEditing = false
        cameraPicker.sourceType = sourceType
        cameraPicker.delegate = context.coordinator

        return cameraPicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<CameraPicker>) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        var parent: CameraPicker

        init(_ parent: CameraPicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
