import SwiftUI
import CoreML

// QUESTA PRIMA PORZIONE DI CODICE RAPPRESENTA LA VIEW
struct EmoRecFunction: View {
    
    @State private var inputImage: UIImage?
    @State private var happyPercentage: String = "0%"
    @State private var worriedPercentage: String = "0%"
    //QUESTA VARIABILE RESTITUISCE IL RIUSLTATO DELLA SCAN
    @State private var risultatofinale: String = ""
    //QUI VA AGGIUNTO IL NOME DEL FILE DA ANALIZZARE
    @State private var imageName: String = "NOME_DEL_FILE_DA_ANALIZZARE"
    
    var body: some View {
        VStack {
            
            Text("RISULTATO : \(risultatofinale)")
                .font(.headline)
                .padding()
            Button("Carica Immagine") {
                loadImage()
            }
            .padding()
            Button("RESET") {
                resetPrediction()
            }
        }
        .padding()
    }
    
    // Funzione per resettare la previsione
    func resetPrediction() {
        risultatofinale = ""
        inputImage = nil
    }
    
    // Funzione per caricare l'immagine nel modello
    func loadImage() {
        if let image = UIImage(named: imageName) {
            inputImage = image
            print("Immagine caricata: \(imageName)") // Log dell'immagine caricata
            predict(image: image)
        } else {
            risultatofinale = "Immagine non trovata"
            
        }
    }
    
    // Funzione per effettuare la previsione
    func predict(image: UIImage) {
        // Ricarica il modello ogni volta
        guard let model = try? ML_FACE_TRAINED(configuration: MLModelConfiguration()) else {

            return
        }
        
        guard let pixelBuffer = image.toCVPixelBuffer() else {
            risultatofinale = "Errore nella conversione dell'immagine"

            return
        }
        
        do {
            let output = try model.prediction(image: pixelBuffer)

            risultatofinale = output.target
            //QUESTE SONO DELLE PRINT PER VEDERE I LOG
            print("Output del modelloo: \(output.target)")

            print("Output del modello: Felice: \(happyPercentage), Preoccupato: \(worriedPercentage)")
        } catch {
            happyPercentage = "Errore nella previsione: \(error.localizedDescription)"
            worriedPercentage = ""
        }
    }
}

// IL SEGUENTE CODICE SI OCCUPA DI CONVERTIRE L'IMMAGINE PASSATA IN UN FORMATO ANALIZZABILE DAL MODELLO
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

#Preview {
    EmoRecFunction()
}

