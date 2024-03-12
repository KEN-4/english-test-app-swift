import Foundation

func debugPrint(_ message: String) {
    #if DEBUG
    print("Debug: \(message)")
    #endif
}
