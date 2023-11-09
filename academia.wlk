object acme{
	method utilidad(cosa){
		return cosa.volumen()/2
	}
}
object fenix{
	method utilidad(cosa){
		if(cosa.reliquia()){
			return 3
		}else{return 0}
	}
}
object cuchuflito{
	method utilidad(cosa){
		return 0
	}
}
class Academias{
	var property contenedores
	
	method yaLoContiene(cosa){
		return contenedores.any({contenedor => contenedor.contiene(cosa)})
	}
	
	method dondeEsta(cosa){
		return contenedores.find({mueble => mueble.contiene(cosa)})
	}
	
	method seGuarda(cosa){
		if(!self.yaLoContiene(cosa)){
			return contenedores.any({mueble => mueble.seGuarda(cosa)})	
		}else{
			return false
		}
	}
	
	method enQueMuebleSeGuarda(cosa){
		if(self.seGuarda(cosa)){
			return contenedores.filter({mueble => mueble.seGuarda(cosa)})
		}else{
			return false
		}
	}
	
	method loGuardo(cosa){
		self.enQueMuebleSeGuarda(cosa).asList().first().add(cosa)	
	}
	
	method menorUtilidad(){
		return contenedores.map({mueble => mueble.menorUtilidad()}).asSet()
	}
	
	method marcaDelMenosUtil(){
		return self.menorUtilidadMenor().marca()
	}
	
	method menorUtilidadMenor(){
		return self.menorUtilidad().min({cosa => cosa.utilidad()})
	}
	
	method comprueboMuebles(){
		return contenedores.size()>=3
	}
	
	method eliminarMenosUtil(){
		if(self.comprueboMuebles()){
			self.dondeEsta(self.menorUtilidadMenor()).remover(self.menorUtilidadMenor()) 
		}
	}
		
}

class Cosas{
	var property marca
	var property volumen
	var property magico
	var property reliquia
	
	method utilidad(){
		return self.volumen() + self.esMagica() + self.esReliquia() + self.marca().utilidad(self) 
	}
	
	method esMagica(){
		if(self.magico()){
			return 3
		}else{return 0}
	}
	
	method esReliquia(){
		if(self.reliquia()){
			return 5
		}else{return 0}
	}
}

const pelota = new Cosas(marca=cuchuflito,volumen=3,magico=false,reliquia=false)
const escoba = new Cosas(marca=acme,volumen=4,magico=true,reliquia=true)
const varita = new Cosas(marca=fenix,volumen=1,magico=true,reliquia=false)
const pava = new Cosas(marca=acme,volumen=2,magico=false,reliquia=true)
const lampara = new Cosas(marca=fenix,volumen=3,magico=true,reliquia=true)

const academia = new Academias(contenedores = #{baul,gabinete,armario})
const baul = new Baul(almacenamiento = #{escoba}, capacidad= 5)
const gabinete = new Gabinete(almacenamiento = #{varita,lampara}, capacidad=0, precio = 6)
const armario = new Armario(almacenamiento = #{pelota,pava}, capacidad= 2)
const baulMagico = new BaulMagico(almacenamiento = #{lampara,escoba}, capacidad= 12)


class Muebles{
	var almacenamiento = #{}
	var property capacidad	
	
	method utilidad(){
		return self.utilidadBase()
	}
	
	method utilidadBase(){
		return (almacenamiento.sum({cosa => cosa.utilidad()}) / self.precio())
	}
	
	method esMagico(cosa){
		return cosa.magico()
	}
	
	method contiene(cosa){
		return almacenamiento.contains(cosa)
	}
	
	method add(cosa){
		almacenamiento.add(cosa)
	}
	
	method precio(){return 1}
	
	method menorUtilidad(){
		return almacenamiento.min({cosa => cosa.utilidad()})
	}
	method remover(cosa){
		almacenamiento.remove(cosa)
	}
}

class Baul inherits Muebles{
	
	
	method seGuarda(cosa){
		return (self.calculoVolumen(cosa) and !self.contiene(cosa))
	}
	
	method volumenActual(){
		return almacenamiento.sum({volumenes => volumenes.volumen()})
	}
	
	method calculoVolumen(cosa){
		return (self.volumenActual()+cosa.volumen()) <= capacidad
	}
	
	override method precio(){
		return capacidad+2
	}
	
	override method utilidad(){
		return self.utilidadBase() + self.sonReliquias()
	}
	
	method sonReliquias(){
		if(almacenamiento.all({cosa => cosa.reliquia()})){
			return 2
		}else{ return 0}
	}
	
}
class BaulMagico inherits Baul{
	override method utilidad(){
		return self.utilidadBase() + self.sonReliquias() + self.cantidadMagico()
	}
	
	method cantidadMagico(){
		return almacenamiento.count({cosa => cosa.magico()})
	}
	
	override method precio(){
		return (capacidad+2)*2
	}
	
}
class Gabinete inherits Muebles{
	var property precio
	
	method seGuarda(cosa){
		return	( self.esMagico(cosa) and !self.contiene(cosa) )
	}
	
	override method utilidadBase(){
		return (almacenamiento.sum({cosa => cosa.utilidad()}) / precio)
	}
	
	override method utilidad(){
		return self.utilidadBase()
	}
	
}

class Armario inherits Muebles{
	
	method seGuarda(cosa){
		return ( self.calculoCantidad() and !self.contiene(cosa) )
	}
	
	method cantidadActual(){
		return almacenamiento.size()
	}
	
	method calculoCantidad(){
		return self.cantidadActual() < capacidad
	}
	
	override method precio(){
		return capacidad*5
	}
	
}





