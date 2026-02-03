/// @description desenha no objeto

if (efeito) //se efeito for true
{
	shader_set(sh_branco); //aplicando o efeito branco
	draw_self(); //desenhnando a sprite
	shader_reset(); //resetando o efeito
}
else //se não
{
	draw_self(); //desenha a sprite normalmente
}