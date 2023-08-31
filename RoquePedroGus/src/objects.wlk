import wollok.game.*
////////////////////////////////////////////
object juego{
	
	method iniciar(){
		
		game.width(16*3)
  		game.height(8*5)
  		game.cellSize(16)
  		game.boardGround("fondo.png")
  		game.title("RPG")
  		
		
		game.addVisual(fondo)
		game.addVisual(personaje)
		game.addVisual(enemigo0)
		game.addVisual(enemigo1)
		game.addVisual(enemigo2)
		
		
		game.onTick(350, "cambioPersonaje", { personaje.animacion() })
		game.onTick(250, "cambioEnemigo0", { enemigo0.animacion() })
		game.onTick(250, "cambioEnemigo1", { enemigo1.animacion() })
		game.onTick(250, "cambioEnemigo2", { enemigo2.animacion() })
		game.onTick(50, "controlEnemigo0", { if(enemigo0.vida()<=0){enemigo0.sprite("enemigoMuerto")} })
		game.onTick(50, "controlEnemigo1", { if(enemigo1.vida()<=0){enemigo1.sprite("enemigoMuerto")} })
		game.onTick(50, "controlEnemigo2", { if(enemigo2.vida()<=0){enemigo2.sprite("enemigoMuerto")} })
		
		//CONTROLES
		keyboard.a().onPressDo { personaje.atacarBasico()}
		keyboard.s().onPressDo { personaje.atacarFuerte() }
		keyboard.i().onPressDo { personaje.fijar(0) 
			game.say((personaje), "Atacare al de medio!!!")
		}
		keyboard.u().onPressDo { personaje.fijar(1) 
			game.say((personaje), "Atacare al del arriba!!!")
		}
		keyboard.o().onPressDo { personaje.fijar(2) 
			game.say((personaje), "Atacare al de abajo!!!")
		}
		
		
		game.start()
		
	}
	
}
///////////////////////////////////////////////
object personaje{
	
	var vida = 100
	var ataqueBasico = 10
	var ataqueFuerte = 30
	var desgaste = 1
	var stamina = 10
	var num = 0
	var sprite = "personaje0"
	var fijar = 0
	
	var property position = game.at(11,12)
	
	method image() = sprite + ".png"
	
	method textColor() = "FF0000"
	
	method animacion(){
		
		//sprite = "personaje1"
		if (num == 0 ){
			
			num = 1
			sprite = "personaje0"
			
		}else{
			if (num == 1){
				
				num = 2
				sprite = "personaje1"
				
			}else{
				//return "error animacion personaje"
				if (num == 2){
					
					num = 3
					sprite = "personaje2"
					
				}else{
					if (num == 3){
						
						num = 0
						sprite = "personaje1"
						
					}else{
						//return "error animacion personaje"
					}
				}
			}
		}
		
	}
	
	method fijar(_fijar){fijar=_fijar}
	
	method atacarBasico(){
	
	if(vida > 0){
		
		if(fijar==0){
	
		if ((enemigo0).vida()>0 and stamina>0){
			
			game.removeTickEvent("cambioPersonaje")
			sprite = "personajeAtaque"
		
			(enemigo0).vida(ataqueBasico)
			game.say((enemigo0), "vida -10")
		
			game.onTick(350, "cambioPersonaje", { self.animacion() })
			
			stamina -= desgaste
			
			game.say((self), "Golpe")
			
			
			
		}
		
		if (enemigo0.vida()>0){
			
			vida -= enemigo0.ataque()
			game.say((self), "vida -5")
			enemigo0.atacar()
			
		}
		
	}
		if(fijar==1){
	
		if ((enemigo1).vida()>0 and stamina>0){
			
			game.removeTickEvent("cambioPersonaje")
			sprite = "personajeAtaque"
		
			(enemigo1).vida(ataqueBasico)
			game.say((enemigo1), "vida -10")
		
			game.onTick(350, "cambioPersonaje", { self.animacion() })
			
			stamina -= desgaste
			
			game.say((self), "Golpe")
			
		}
		
		if (enemigo1.vida()>0){
			
			vida -= enemigo1.ataque()
			game.say((self), "vida -5")
			enemigo1.atacar()
			
		}
		
	}
		if(fijar==2){
	
		if ((enemigo2).vida()>0 and stamina>0){
			
			game.removeTickEvent("cambioPersonaje")
			sprite = "personajeAtaque"
		
			(enemigo2).vida(ataqueBasico)
			game.say((enemigo2), "vida -10")
		
			game.onTick(350, "cambioPersonaje", { self.animacion() })
			
			stamina -= desgaste
			
			game.say((self), "Golpe")
			
		}
		if (enemigo2.vida()>0){
			
			vida -= enemigo2.ataque()
			game.say((self), "vida -5")
			enemigo2.atacar()
			
		}
	}
	
		stamina += desgaste
	
		if (vida<=0){
			
			game.removeTickEvent("cambioPersonaje")
			sprite = "personajeMuerto"
			
			game.say((enemigo0), "Ahhhhggg")
			game.say((enemigo1), "Ahhhhggg")
			game.say((enemigo2), "Ahhhhggg")
			
			game.say((self), "*Abatido*")
			
		}
	
		if (stamina<=0){
		
			game.say((self), "No me queda energía...")
		
		}
	}
	
}
	
	method atacarFuerte(){
	if(vida > 0){	
	if(fijar==0){
	
		if ((enemigo0).vida()>0 and stamina>0){
			
			game.removeTickEvent("cambioPersonaje")
			sprite = "personajeAtaque"
		
			(enemigo0).vida(ataqueFuerte)
			game.say((enemigo0), "vida -30")
		
			game.onTick(350, "cambioPersonaje", { self.animacion() })
			
			stamina -= desgaste*2
			
			game.say((self), "Mega Puño!!!")
			
		}
		if (enemigo0.vida()>0){
			
			vida -= enemigo0.ataque()
			game.say((self), "vida -5")
			enemigo0.atacar()
			
		}
	}
	if(fijar==1){
	
		if ((enemigo1).vida()>0 and stamina>0){
			
			game.removeTickEvent("cambioPersonaje")
			sprite = "personajeAtaque"
		
			(enemigo1).vida(ataqueFuerte)
			game.say((enemigo1), "vida -30")
		
			game.onTick(350, "cambioPersonaje", { self.animacion() })
			
			stamina -= desgaste*2
			
			game.say((self), "Mega Puño!!!")
			
		}
		if (enemigo1.vida()>0){
			
			vida -= enemigo1.ataque()
			game.say((self), "vida -5")
			enemigo1.atacar()
			
		}
	}
	if(fijar==2){
	
		if ((enemigo2).vida()>0 and stamina>0){
			
			game.removeTickEvent("cambioPersonaje")
			sprite = "personajeAtaque"
		
			(enemigo2).vida(ataqueFuerte)
			game.say((enemigo2), "vida -30")
		
			game.onTick(350, "cambioPersonaje", { self.animacion() })
			
			stamina -= desgaste*2
			
			game.say((self), "Mega Puño!!!")
			
		}
		if (enemigo2.vida()>0){
			
			vida -= enemigo2.ataque()
			game.say((self), "vida -5")
			enemigo2.atacar()
			
		}
	}	
	
	stamina += desgaste	
	if (vida<=0){
			
			game.removeTickEvent("cambioPersonaje")
			sprite = "personajeMuerto"
			
			game.say((enemigo0), "Ahhhhggg")
			game.say((enemigo1), "Ahhhhggg")
			game.say((enemigo2), "Ahhhhggg")
			
			game.say((self), "*Abatido*")
			
		}
	
		if (stamina<=0){
		
			game.say((self), "No me queda energía...")
		
		}
	
	}	
	if (stamina<=0){
		
		game.say((self), "No me queda energía")
		
	}
		
}
	
	method vida(){return vida}
	
	method vida(_vida){vida-=_vida}
}
//////////////////////////////////////
object enemigo0{
	
	var vida = 100 
	var ataque = 5
	var num = 0
	var sprite = "enemigo0"
	
	var property position = game.at(33,12)
	
	method ataque(){return ataque}
	
	method atacar(){
		
		game.removeTickEvent("cambioEnemigo0")
		game.schedule(1000, { sprite = "enemigoAtaca"
			game.say((self), "Lenguetazo")
		})
		
		
		game.onTick(350, "cambioEnemigo0", { self.animacion() })
			
			
		
	}
	
	method image() = sprite + ".png"
	
	method textColor() = "FF0000"
	
	method animacion(){
		
		
		if (num == 0 ){
			
			num = 1
			sprite = "enemigo0"
			
		}else{
			if (num == 1){
				
				num = 2
				sprite = "enemigo1"
				
			}else{
				
				if (num == 2){
					
					num = 3
					sprite = "enemigo2"
					
				}else{
					if (num == 3){
						
						num = 0
						sprite = "enemigo1"
						
					}else{
						//return "error animacion personaje"
					}
				}
			}
		}
		
	}
	
	method vida(){return vida}
	
	method vida(_vida){
		
		vida-=_vida
		
		game.removeTickEvent("cambioEnemigo0")
		
		sprite="enemigoDanado"
		
		game.onTick(250, "cambioEnemigo0", { self.animacion() })
		
	
		if (vida <= 0){
			
			game.removeTickEvent("cambioEnemigo0")
			sprite="enemigoMuerto"
			
		}
		
	}
	
	method sprite(){return sprite}
	
	method sprite(_sprite){sprite=_sprite}
}
///////////////////////////////////////////////////////////////
object enemigo1{
	
	var vida = 100 
	var num = 0
	var ataque = 5
	var sprite = "enemigo0"
	
	var property position = game.at(29,18)
	
	method ataque(){return ataque}
	
	method atacar(){
		
		game.removeTickEvent("cambioEnemigo1")
		game.schedule(1000, { sprite = "enemigoAtaca"
			game.say((self), "Lenguetazo")
		})
		
		game.onTick(350, "cambioEnemigo1", { self.animacion()})
			
			
		
	}
	
	method image() = sprite + ".png"
	
	method textColor() = "FF0000"
	
	method animacion(){
		
		
		if (num == 0 ){
			
			num = 1
			sprite = "enemigo0"
			
		}else{
			if (num == 1){
				
				num = 2
				sprite = "enemigo1"
				
			}else{
				
				if (num == 2){
					
					num = 3
					sprite = "enemigo2"
					
				}else{
					if (num == 3){
						
						num = 0
						sprite = "enemigo1"
						
					}else{
						//return "error animacion personaje"
					}
				}
			}
		}
		
	}
	
	method vida(){return vida}
	
	method vida(_vida){
		
		vida-=_vida
		
		game.removeTickEvent("cambioEnemigo1")
		
		sprite="enemigoDanado"
		
		game.onTick(250, "cambioEnemigo1", { self.animacion() })
		
	
		if (vida <= 0){
			
			game.removeTickEvent("cambioEnemigo1")
			sprite="enemigoMuerto"
			
		}
		
	}
	
	method sprite(){return sprite}
	
	method sprite(_sprite){sprite=_sprite}
}
////////////////////////////////////////////////////////////////
object enemigo2{
	
	var vida = 100 
	var num = 0
	var ataque = 5
	var sprite = "enemigo0"
	
	var property position = game.at(37,6)
	
	method ataque(){return ataque}
	
	method atacar(){
		
		game.removeTickEvent("cambioEnemigo2")
		game.schedule(1000, { sprite = "enemigoAtaca"
			game.say((self), "Lenguetazo")
		})
		
		game.onTick(350, "cambioEnemigo2", { self.animacion() })
			
			
		
	}
	
	method image() = sprite + ".png"
	
	method textColor() = "FF0000"
	
	method animacion(){
		
		
		if (num == 0 ){
			
			num = 1
			sprite = "enemigo0"
			
		}else{
			if (num == 1){
				
				num = 2
				sprite = "enemigo1"
				
			}else{
				
				if (num == 2){
					
					num = 3
					sprite = "enemigo2"
					
				}else{
					if (num == 3){
						
						num = 0
						sprite = "enemigo1"
						
					}else{
						//return "error animacion personaje"
					}
				}
			}
		}
		
	}
	
	method vida(){return vida}
	
	method vida(_vida){
		
		vida-=_vida
		
		game.removeTickEvent("cambioEnemigo2")
		
		sprite="enemigoDanado"
		
		game.onTick(250, "cambioEnemigo2", { self.animacion() })
		
	
		if (vida <= 0){
			
			game.removeTickEvent("cambioEnemigo2")
			sprite="enemigoMuerto"
			
		}
		
	}
	
	method sprite(){return sprite}
	
	method sprite(_sprite){sprite=_sprite}
	
}
/////////////////////////////////////////////////////////////////
object fondo{
	
	var property position = game.at(0,0)
	
	method image() = "fondo0.png"

}
