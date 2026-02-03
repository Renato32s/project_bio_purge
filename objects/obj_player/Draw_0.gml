/// @description desenha no objeto

if (tomei_dano)
{
	shader_set(sh_branco); //setando o shader
	//desenhando a sprite do player
	draw_sprite_ext(sprite_index, image_index, x, y, xscale, yscale, image_angle, image_blend, image_alpha);
	shader_reset(); //resetando o set_shader
}
else //se não
{
	draw_sprite_ext(sprite_index, image_index, x, y, xscale, yscale, image_angle, image_blend, image_alpha);
}