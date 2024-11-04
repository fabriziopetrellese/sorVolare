import UIKit
import CoreML
import Vision

class EmoRecFunction {
    
    // VARIABILE CHE CONTIENE L'IMMAGINE DA ANALIZZARE
    var inputImage: UIImage?
    
    // RISULTATO PREVISIONE
    var risultatofinale: String = ""
    
    //NOME DEL FILE DA ANALIZZARE PER EVENTUALI TEST
    var imageName: String = "NOME_DEL_FILE_DA_ANALIZZARE"
    
    // FUNZIONE PER RESETTARE L'INTERA PREVISIONE
    func resetPrediction() {
        risultatofinale = ""
        inputImage = nil
    }
    
    // FUNZIONE PER CARICARE L'IMMAGINE E CHE ATTIVA LA FACE DETECTION
    func loadImage() {
        if let image = inputImage {
            print("Immagine caricata dall'input: \(imageName)") // Log dell'immagine caricata
            detectFace(in: image) // Rileva il volto prima di fare la previsione
        } else {
            // Se inputImage non è impostata, prova a caricare l'immagine dal nome del file
            if let image = UIImage(named: imageName) {
                inputImage = image
                print("Immagine caricata: \(imageName)") // Log dell'immagine caricata
                detectFace(in: image) // Rileva il volto prima di fare la previsione
            } else {
                risultatofinale = "Immagine non trovata"
            }
        }
    }
    
    //FUNZIONE RITAGLIARE E RILEVARE IL VOLTO NELL'IMMAGINE
    func detectFace(in image: UIImage) {
        guard let cgImage = image.cgImage else {
            risultatofinale = "Errore nella conversione dell'immagine"
            return
        }
        let request = VNDetectFaceRectanglesRequest { (request, error) in
            if let results = request.results as? [VNFaceObservation], let face = results.first {
                
                let boundingBox = face.boundingBox
                let width = image.size.width
                let height = image.size.height
                
                let x = boundingBox.origin.x * width
                let y = boundingBox.origin.y * height
                let faceWidth = boundingBox.size.width * width
                let faceHeight = boundingBox.size.height * height
                
                let faceRect = CGRect(x: x, y: y, width: faceWidth, height: faceHeight)
                
                if let faceImage = image.cgImage?.cropping(to: faceRect) {
                    let croppedUIImage = UIImage(cgImage: faceImage)
                    self.predict(image: croppedUIImage) // PASSA IL VOLTO AL MODELLO
                } else {
                    self.risultatofinale = "Errore nel ritaglio dell'immagine"
                }
            } else {
                self.risultatofinale = "Nessun volto rilevato"
            }
        }
        
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do {
            try handler.perform([request])
        } catch {
            risultatofinale = "Errore nella richiesta di rilevamento: \(error.localizedDescription)"
            
        }
        print("risultato ritaglio: \(risultatofinale)")
    }
    
    //FUNZIONE CHE ESEGUE LA PREVISIONE SULLA FOTO
    func predict(image: UIImage) {
        // RICARICA IL MODELLO OGNI VOLTA PER EVITARE PROBLEMI DI CACHING
        guard let model = try? ML_FACE_TRAINED(configuration: MLModelConfiguration()) else {
            return
        }
        guard let pixelBuffer = image.toCVPixelBuffer() else {
            risultatofinale = "Errore nella conversione dell'immagine"
            print("risultato previsione: \(risultatofinale)")
            return
        }
        
        do {
            let output = try model.prediction(image: pixelBuffer)
            risultatofinale = output.target
            //LOG DELLA PREVISIONE
            print("Output del modello: \(output.target)")
            print("probabilità: \(output.targetProbability)")
        } catch {
            risultatofinale = "Errore nella previsione: \(error.localizedDescription)"
            print("Errore nella previsione: \(error.localizedDescription)")
        }
    }
}

// ESTENSIONE PER RENDERE L'IMMAGINE LEGGIBILE PER IL MODELLO
extension UIImage {
    func toCVPixelBuffer() -> CVPixelBuffer? {
        let width = Int(size.width)
        let height = Int(size.height)
        let attrs = [
            kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue!,
            kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue!
        ] as CFDictionary
        
        var pixelBuffer: CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault,
                                          width,
                                          height,
                                          kCVPixelFormatType_32ARGB,
                                          attrs,
                                          &pixelBuffer)
        
        guard status == noErr, let buffer = pixelBuffer else {
            return nil
        }
        
        CVPixelBufferLockBaseAddress(buffer, [])
        let pixelData = CVPixelBufferGetBaseAddress(buffer)
        
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        
        let context = CGContext(data: pixelData,
                                width: width,
                                height: height,
                                bitsPerComponent: 8,
                                bytesPerRow: CVPixelBufferGetBytesPerRow(buffer),
                                space: rgbColorSpace,
                                bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
        
        context?.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: width, height: height))
        CVPixelBufferUnlockBaseAddress(buffer, [])
        
        return buffer
    }
}
