import SwiftUI
import CoreImage.CIFilterBuiltins
import Contacts
import CoreNFC

class BusinessCardViewModel: NSObject, ObservableObject, NFCNDEFReaderSessionDelegate {
    @Published var name: String = ""
    @Published var phone: String = ""
    @Published var email: String = ""
    @Published var company: String = ""
    @Published var jobTitle: String = ""
    @Published var qrCodeImage: UIImage?

    private let context = CIContext()
    private let filter = CIFilter.qrCodeGenerator()

    func generateVCard() -> String {
        return """
        BEGIN:VCARD
        VERSION:3.0
        N:\(name)
        TEL:\(phone)
        EMAIL:\(email)
        ORG:\(company)
        TITLE:\(jobTitle)
        END:VCARD
        """
    }

    func generateQRCode() {
        let vCard = generateVCard()
        let data = Data(vCard.utf8)
        filter.setValue(data, forKey: "inputMessage")

        if let outputImage = filter.outputImage,
           let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            qrCodeImage = UIImage(cgImage: cgimg)
        }
    }

    func beginNFCWrite() {
        guard NFCNDEFReaderSession.readingAvailable else { return }
        let session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
        session.alertMessage = "Hold your iPhone near the NFC tag."
        session.begin()
    }

    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {}

    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        let vCard = generateVCard()
        let payload = NFCNDEFPayload.wellKnownTypeURIPayload(string: vCard)
        let message = NFCNDEFMessage(records: [payload!])
        session.connect(to: session.connectedTag!) { error in
            guard error == nil else { return }
            (session.connectedTag as? NFCNDEFTag)?.writeNDEF(message, completionHandler: { _, _ in
                session.invalidate()
            })
        }
    }
}

struct ContentView: View {
    @StateObject private var viewModel = BusinessCardViewModel()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Contact Info")) {
                    TextField("Full Name", text: $viewModel.name)
                    TextField("Phone", text: $viewModel.phone)
                    TextField("Email", text: $viewModel.email)
                    TextField("Company", text: $viewModel.company)
                    TextField("Job Title", text: $viewModel.jobTitle)
                }

                Section {
                    Button("Generate QR Code") {
                        viewModel.generateQRCode()
                    }
                    if let qr = viewModel.qrCodeImage {
                        Image(uiImage: qr)
                            .resizable()
                            .interpolation(.none)
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .padding()
                    }
                }

                Section {
                    Button("Write to NFC Tag") {
                        viewModel.beginNFCWrite()
                    }
                }
            }
            .navigationTitle("Smart QR Business Card")
        }
    }
}

@main
struct SmartQRApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

import SwiftUI
import CoreImage.CIFilterBuiltins
import Contacts
import CoreNFC

class BusinessCardViewModel: NSObject, ObservableObject, NFCNDEFReaderSessionDelegate {
    @Published var name: String = ""
    @Published var phone: String = ""
    @Published var email: String = ""
    @Published var company: String = ""
    @Published var jobTitle: String = ""
    @Published var qrCodeImage: UIImage?

    private let context = CIContext()
    private let filter = CIFilter.qrCodeGenerator()

    func generateVCard() -> String {
        return """
        BEGIN:VCARD
        VERSION:3.0
        N:\(name)
        TEL:\(phone)
        EMAIL:\(email)
        ORG:\(company)
        TITLE:\(jobTitle)
        END:VCARD
        """
    }

    func generateQRCode() {
        let vCard = generateVCard()
        let data = Data(vCard.utf8)
        filter.setValue(data, forKey: "inputMessage")

        if let outputImage = filter.outputImage,
           let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            qrCodeImage = UIImage(cgImage: cgimg)
        }
    }

    func beginNFCWrite() {
        guard NFCNDEFReaderSession.readingAvailable else { return }
        let session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
        session.alertMessage = "Hold your iPhone near the NFC tag."
        session.begin()
    }

    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {}

    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        let vCard = generateVCard()
        let payload = NFCNDEFPayload.wellKnownTypeURIPayload(string: vCard)
        let message = NFCNDEFMessage(records: [payload!])
        session.connect(to: session.connectedTag!) { error in
            guard error == nil else { return }
            (session.connectedTag as? NFCNDEFTag)?.writeNDEF(message, completionHandler: { _, _ in
                session.invalidate()
            })
        }
    }
}

struct ContentView: View {
    @StateObject private var viewModel = BusinessCardViewModel()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Contact Info")) {
                    TextField("Full Name", text: $viewModel.name)
                    TextField("Phone", text: $viewModel.phone)
                    TextField("Email", text: $viewModel.email)
                    TextField("Company", text: $viewModel.company)
                    TextField("Job Title", text: $viewModel.jobTitle)
                }

                Section {
                    Button("Generate QR Code") {
                        viewModel.generateQRCode()
                    }
                    if let qr = viewModel.qrCodeImage {
                        Image(uiImage: qr)
                            .resizable()
                            .interpolation(.none)
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .padding()
                    }
                }

                Section {
                    Button("Write to NFC Tag") {
                        viewModel.beginNFCWrite()
                    }
                }
            }
            .navigationTitle("Smart QR Business Card")
        }
    }
}

@main
struct SmartQRApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}