/// @description controla o objeto

//verificando se o tiro saiu da tela
if (y <= -32)
{
	//se ele sair da tela, deve se destruir
	instance_destroy();
}