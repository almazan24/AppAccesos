import SwiftUI

struct ContentView: View {
    @State private var irPanel: Bool = false

    var body: some View {
        NavigationStack {
            LoginVista(irPanel: $irPanel)
                .navigationDestination(isPresented: $irPanel) {
                    PanelPrincipalVista()
                }
        }
    }
}

struct LoginVista: View {
    @Binding var irPanel: Bool

    @State private var usuario: String = ""
    @State private var contrasena: String = ""
    @State private var mostrarError: Bool = false
    @State private var mostrarRegistroEntrada: Bool = false

    var body: some View {
        
        VStack(spacing: 24) {
            Spacer(minLength: 20)

            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(height: 120)
                .padding(.horizontal, 32)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.secondarySystemBackground))
                )
                .clipShape(RoundedRectangle(cornerRadius: 16))

            Text("SERVICIOS INTEGRALES DE ALIMENTOS VITA")
                .font(.system(size: 18, weight: .bold))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
                .sheet(isPresented: $mostrarRegistroEntrada) {
                    RegistroEntradaFlotante()
                        .presentationDetents([.fraction(0.50), .medium]) // panel parcial que sube
                        .presentationDragIndicator(.visible)
                        .presentationCornerRadius(24)
                }

            VStack(spacing: 16) {
                CampoTexto(titulo: "Usuario", texto: $usuario)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()

                CampoSeguro(titulo: "Contraseña", texto: $contrasena)
            }
            .padding(.horizontal, 24)

            Button(action: validarCredenciales) {
                Text("Iniciar sesión")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color.orange)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .shadow(radius: 2, y: 1)
            }
            .padding(.horizontal, 24)

            Button { mostrarError = true } label: {
                Text("Olvidé mi contraseña")
                    .underline()
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }
            Button {
                mostrarRegistroEntrada = true
            } label: {
                Text("Registrar nueva entrada")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color.orange)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .shadow(radius: 2, y: 1)
            }
            .padding(.horizontal, 24)


            Spacer(minLength: 20)
        }
        .alert("Acceso denegado", isPresented: $mostrarError) {
            Button("Aceptar", role: .cancel) { }
        } message: {
            Text("Verifica tu usuario y contraseña o contacta a IT.")
        }
    }
    
    struct RegistroEntradaFlotante: View {
        var body: some View {
            VStack(spacing: 20) {
                Text("Acerca tu credencial al lector")
                    .font(.title2.bold())
                    .multilineTextAlignment(.center)
                    .padding(.top, 16)

                Image("logo_vector")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 160)
                    .padding(.horizontal, 24)

                Spacer(minLength: 8)

                Button {
                    // aquí conectarás la lógica de registro manual
                } label: {
                    Text("Registrar entrada manualmente")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.orange.opacity(0.95))
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                        .shadow(radius: 2, y: 1)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 12)
            }
            .frame(maxWidth: .infinity)
            .background(Color(.systemBackground))
        }
    }

    

    private func validarCredenciales() {
        if usuario == "Admin" && contrasena == "1234" {
            irPanel = true
        } else {
            mostrarError = true
        }
    }
}

struct CampoTexto: View {
    let titulo: String
    @Binding var texto: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(titulo)
                .font(.headline)
            TextField(titulo, text: $texto)
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.primary.opacity(0.25), lineWidth: 1.4)
                )
        }
    }
}

struct CampoSeguro: View {
    let titulo: String
    @Binding var texto: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(titulo)
                .font(.headline)
            
            SecureField(titulo, text: $texto)
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.primary.opacity(0.25), lineWidth: 1.4)
                )
        }
        
    }
    
}

struct PanelPrincipalVista: View {
    @Environment(\.dismiss) private var cerrar

    struct EmpleadoRegistro: Identifiable {
        let id = UUID()
        let numEmpleado: String
        let nombre: String
        let puesto: String
        let horaEntrada: Date
        let horaSalida: Date?
    }

    private let registros: [EmpleadoRegistro] = {
        func hora(_ h: Int, _ m: Int) -> Date {
            var c = Calendar.current.dateComponents([.year, .month, .day], from: Date())
            c.hour = h; c.minute = m
            return Calendar.current.date(from: c) ?? Date()
        }
        return [
            .init(numEmpleado: "0825", nombre: "María López",     puesto: "Supervisora de Producción", horaEntrada: hora(7, 2),  horaSalida: nil),
            .init(numEmpleado: "2456", nombre: "Carlos Pérez",    puesto: "Cocinero",         horaEntrada: hora(6, 55), horaSalida: hora(15, 5)),
            .init(numEmpleado: "2134", nombre: "Ana García",      puesto: "Calidad",                    horaEntrada: hora(7, 10), horaSalida: hora(16, 0)),
            .init(numEmpleado: "6783", nombre: "Luis Hernández",  puesto: "Mantenimiento",              horaEntrada: hora(8, 0),  horaSalida: nil),
            .init(numEmpleado: "0954", nombre: "Sofía Torres",    puesto: "Recursos Humanos",           horaEntrada: hora(9, 0),  horaSalida: hora(18, 2))
        ]
    }()

    private static let formatoHora: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "HH:mm"
        return f
    }()

    private func textoHora(_ d: Date?) -> String {
        guard let d = d else { return "—" }
        return Self.formatoHora.string(from: d)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Dashboard")
                    .font(.largeTitle.bold())
                    .padding(.top, 8)
                    .frame(maxWidth: .infinity, alignment: .center)

                ForEach(registros) { r in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text(r.horaSalida == nil ? "En planta" : "Finalizado")
                                .font(.caption.bold())
                                .padding(.horizontal, 10).padding(.vertical, 6)
                                .background(r.horaSalida == nil ? Color.orange.opacity(0.2) : Color.green.opacity(0.2))
                                .clipShape(Capsule())
                            Spacer()
                        }

                        Group {
                            Text("Nombre del empleado: ").bold() + Text(r.nombre)
                            Text("Numero de empleado: ").bold() + Text(r.numEmpleado)
                            Text("Puesto: ").bold() + Text(r.puesto)
                            Text("Hora entrada: ").bold() + Text(textoHora(r.horaEntrada))
                            Text("Hora salida: ").bold() + Text(textoHora(r.horaSalida))
                        }
                        .font(.body)

                    }
                    .padding(16)
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(Color(.systemBackground))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(Color.primary.opacity(0.12), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 90)
        }
        .background(Color(.systemGroupedBackground))
        .safeAreaInset(edge: .bottom) {
            Button {
                cerrar()
            } label: {
                Text("Cerrar sesión")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color.red.opacity(0.9))
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .padding(.horizontal, 16)
                    .padding(.bottom, 8)
            }
            .background(.ultraThinMaterial)
        }
    }
}


#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
