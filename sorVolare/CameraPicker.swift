//
//  CameraPicker.swift
//  sorVolare
//
//  Created by Fabrizio Petrellese on 30/10/24.
//

import SwiftUI
import AVFoundation

// Camera Picker veniva richiamato in questo modo da una ContentView, in questo esempio c'è un semplice bottone
// e quando ci clicchi sopra ti scatta la foto
/*
struct ContentView: View {

    @State private var capturedImage: UIImage? = nil
    private var cameraManager = CameraManager() // Manager per gestire la sessione della fotocamera

    var body: some View {
        VStack {
            if let image = capturedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.7)
            } else {
                Text("No Image Captured")
                    .font(.title)
                    .padding()
            }

            Button("Capture Image") {
                cameraManager.startCapture { image in
                    self.capturedImage = image
                }
            }
            .font(.title2)
            .padding()
        }
    }
}
*/

// Camera Manager per la gestione della sessione della fotocamera
class CameraManager: NSObject, AVCapturePhotoCaptureDelegate {

    private let captureSession = AVCaptureSession()
    private let photoOutput = AVCapturePhotoOutput()
    private var completion: ((UIImage?) -> Void)?

    override init() {
        super.init()
        setupCamera()
    }

    private func setupCamera() {
        guard let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front),
              let input = try? AVCaptureDeviceInput(device: frontCamera) else { return }

        captureSession.beginConfiguration()
        if captureSession.canAddInput(input) {
            captureSession.addInput(input)
        }
        if captureSession.canAddOutput(photoOutput) {
            captureSession.addOutput(photoOutput)
        }
        captureSession.commitConfiguration()
    }

    func startCapture(completion: @escaping (UIImage?) -> Void) {
        self.completion = completion

        // Avvia la sessione di acquisizione su un thread di background
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()

            // Scatta automaticamente la foto dopo 2 secondi
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                let settings = AVCapturePhotoSettings()
                self.photoOutput.capturePhoto(with: settings, delegate: self)
            }
        }
    }

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print("Error capturing photo: \(error)")
            completion?(nil)
            return
        }

        if let data = photo.fileDataRepresentation(),
           let image = UIImage(data: data) {
            completion?(image)
        } else {
            completion?(nil)
        }

        // Stoppa la sessione dopo la cattura
        DispatchQueue.global(qos: .background).async {
            self.captureSession.stopRunning()
        }
    }
}
