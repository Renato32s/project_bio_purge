/// @description controla o objeto

//verificando se o tiro saiu da room
if (y >= room_height + 32) //se o y for maior ou igual a +32(positivo no eixo_y vai pra baixo)
{
	instance_destroy(); //a instancia é destruida
}