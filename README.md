# 📇 Smart QR Business Card (Swift + NFC + Contacts)

A SwiftUI-based iOS app that generates scannable business cards as QR codes based on your contact information. Optionally, the app allows writing the contact data to an NFC tag for one-tap sharing. Ideal for networking, smart IDs, or event check-ins.


## 🚀 Features

- ✨ Generate dynamic QR codes from user input
- 📲 Share contact details instantly via QR or NFC
- 🧠 Smart UI with input validation and preview
- 🔐 Local, offline processing for privacy
- 💡 Supports vCard format for wide compatibility


## 🛠 Tech Stack

- Swift 5.9
- SwiftUI for UI
- CoreImage for QR code generation
- CoreNFC for NFC tag writing
- Contacts framework


## 📥 How to Run

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/smart-qr-business-card-swift.git
   cd smart-qr-business-card-swift
   ```

2. **Open in Xcode**
   - Open `smart-qr-business-card-swift.xcodeproj` or `.xcworkspace` in Xcode 15+

3. **Setup Requirements**
   - Enable NFC capability in *Signing & Capabilities*
   - Use a real iOS device (NFC doesn't work on the simulator)

4. **Run the App**
   - Input contact info and tap "Generate QR"
   - Tap "Write to NFC Tag" to save it onto a physical tag


## 📌 Use Cases

- Digital business cards
- Event badges and check-ins
- Smart contact sharing with NFC
- Personal or branded QR cards
