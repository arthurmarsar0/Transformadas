import SwiftUI

struct MonthYearPicker: View {
    @Binding var selectedDate: Date

    var body: some View {
        DatePicker(
            "Selecione Mês e Ano",
            selection: $selectedDate,
            displayedComponents: [.date]
        )
        .datePickerStyle(.wheel)  // Estilo do picker como roda
        .labelsHidden()            // Esconde o rótulo "Selecione Mês e Ano"
    }
}
