import Foundation

struct Order: Decodable {
    let id: Int
    let doctor: Doctor?
    let clinic: Clinic?
    let files: [String]? // needs type
    let progress: String
    let date: String
    let patient: String
    let comment: String?
    let deadline: String?
    let totalPrice: Int
    let isClosed: Bool
    let balance: Int //
    let works: [String] // needs type
    let operations: [String] // needs type
    let paidBy: [String] // needs type

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case doctor = "doctor"
        case clinic = "clinic"
        case files = "files"
        case progress = "progress"
        case date = "date"
        case patient = "patient"
        case comment = "comment"
        case deadline = "deadline"
        case totalPrice = "total_price"
        case isClosed = "is_closed"
        case balance = "balance"
        case works = "works"
        case operations = "operations"
        case paidBy = "paid_by"
    }
}
