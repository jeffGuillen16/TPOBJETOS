object chasqui
{
	method puedeEnviarMensaje(mensaje)
	{
		return mensaje.size() < 50
	}
	
	method costeMensaje(mensaje)
	{
		return 2*mensaje.size()
	}
}

object sherpa
{
	//Lo defino como property ya que puede cambiar a futuro
	var property costePorMensaje = 60
	
	method puedeEnviarMensaje(mensaje)
	{
		return mensaje.size().even()
	}
	
	method costeMensaje()
	{
		return costePorMensaje
	}
}

object messich
{
	var property multiplicadorCoste = 10
	
	method puedeEnviarMensaje(mensaje)
	{
		return mensaje.take(1) != 'a'
	}
	
	method costeMensaje(mensaje)
	{
		return multiplicadorCoste * (mensaje.split(" ").size())
	}
}

object pali
{
	
}