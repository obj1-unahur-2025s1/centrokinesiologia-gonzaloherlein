class Paciente{
  var edad
  var nivelDeFortaleza
  var nivelDeDolor
  const property rutinaAsignada = []

  method puedeUsar(unAparato) = unAparato.puedeUsarse(self)

  method disminuirNivelDeDolor(nuevoNivelDeDolor){
    nivelDeDolor = (nivelDeDolor - nuevoNivelDeDolor).max(0)
  }

  method aumentarNivelDeFortaleza(nuevoNivelDeFortaleza){
    nivelDeFortaleza += nuevoNivelDeFortaleza
  }

  method nivelDeDolor() = nivelDeDolor

  method nivelDeFortaleza() = nivelDeFortaleza

  method edad() = edad

  method usarAparato(unAparato){
    if(self.puedeUsar(unAparato)){
      unAparato.usarse(self)
    }
  }

  method puedeHacerLaRutinaAsignada() = rutinaAsignada.all({ a => self.puedeUsar(a)})

  method realizarRutinaAsignada(){rutinaAsignada.forEach({ a => self.usarAparato(a)})}

  method hayAparatoDeColor(unColor) = rutinaAsignada.any({a => a.color() == unColor})
}

class Resistente inherits Paciente{
  override method realizarRutinaAsignada(){
    super()
    self.aumentarNivelDeFortaleza(self.rutinaAsignada().size())
  }
}

class Caprichoso inherits Paciente{
  override method puedeHacerLaRutinaAsignada() = super() && self.hayAparatoDeColor("rojo")

  override method realizarRutinaAsignada(){
    super()
    super()
  }
}

class RapidaRecuperacion inherits Paciente{
  var decremento = 3
  override method realizarRutinaAsignada(){
    super()
    self.disminuirNivelDeDolor(decremento)
  }

  method asignarValorDeDecremento(valor){
    decremento = valor
  }
}

class Aparato{
  var color = "blanco"

  method puedeUsarse(unPaciente)

  method usarse(unPaciente)

  method color() = color

  method necesitaMantenimiento()

  method realizarMantenimiento()
}


class Magneto inherits Aparato{
  var imantacion = 800

  override method puedeUsarse(unPaciente) = true

  override method usarse(unPaciente){
    unPaciente.disminuirNivelDeDolor(unPaciente.nivelDeDolor() * 0.10)
    imantacion -= 1
  }

  override method necesitaMantenimiento() = imantacion < 100

  override method realizarMantenimiento(){
    imantacion = (imantacion + 500).min(800)
  }
}

class Bicicleta inherits Aparato{
  var tornillosDesajustados = 0
  var cantVecesPierdeAceite = 0

  override method puedeUsarse(unPaciente) = unPaciente.edad() > 8

  override method usarse(unPaciente){
    if(unPaciente.nivelDeDolor() > 30){
      tornillosDesajustados += 1
    }else(unPaciente.nivelDeDolor() > 30 && unPaciente.edad().between(30, 50)){
      cantVecesPierdeAceite += 1
    }
    unPaciente.disminuirNivelDeDolor(4)
    unPaciente.aumentarNivelDeFortaleza(3)
  }

  override method necesitaMantenimiento() = tornillosDesajustados >= 10 || cantVecesPierdeAceite >= 5

  override method realizarMantenimiento(){
    tornillosDesajustados = 0
    cantVecesPierdeAceite = 0
  }
}

class Minitramp inherits Aparato{
  override method puedeUsarse(unPaciente) = unPaciente.nivelDeDolor() < 20

  override method usarse(unPaciente){
    unPaciente.aumentarNivelDeFortaleza(unPaciente.edad() * 0.10)
  }

  override method necesitaMantenimiento() = false

  override method realizarMantenimiento(){

  }
}

class Centro{
  const property aparatos = #{}
  const property pacientes = #{}

  method coloresDeLosAparatos() = aparatos.map({ a => a.color()}).asSet()

  method pacientesMenoresDe8Anios() = pacientes.filter({ p => p.edad() < 8})

  method cantidadDePacientesQueNoCumplenSuSesion() = pacientes.count({ p => !p.puedeHacerLaRutinaAsignada()})

  method estaEnOptimasCondiciones() = aparatos.all({a => !a.necesitaMantenimiento()})

  method estaComplicado() = aparatos.count({ a => a.necesitaMantenimiento()}) >= (aparatos.size() / 2)

  method aparatosQueNecesitanMantenimiento() = aparatos.filter({ a => a.necesitaMantenimiento()})

  method registrarVisitaTecnico(){
    self.aparatosQueNecesitanMantenimiento().forEach({a => a.realizarMantenimiento()})
  }
}